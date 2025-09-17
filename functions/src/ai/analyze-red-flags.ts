import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { OpenAI } from 'openai';
import { z } from 'zod';
import { enforceCaps, incrementUsage } from '../utils/usage';
import { extractSignals, rulesScore, buildRadarPrompt } from '../utils/radar-logic';

const openai = new OpenAI({
  apiKey: functions.config().openai.api_key,
});

const AnalyzeRedFlagsRequest = z.object({
  profileId: z.string(),
});

const RadarResponse = z.object({
  compatibility: z.number().min(0).max(100),
  pillars: z.object({
    values: z.number().min(0).max(100),
    emotional_safety: z.number().min(0).max(100),
    effort_consistency: z.number().min(0).max(100),
    consistency_words_actions: z.number().min(0).max(100),
  }),
  flags: z.array(z.object({
    key: z.string(),
    why: z.string(),
  })),
  strengths: z.array(z.object({
    key: z.string(),
    why: z.string(),
  })),
  next_step: z.string(),
  short_summary: z.string(),
});

export const analyzeRedFlags = async (data: any, context: functions.https.CallableContext) => {
  // Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  try {
    // Validate request
    const { profileId } = AnalyzeRedFlagsRequest.parse(data);
    const uid = context.auth.uid;

    // Enforce usage caps
    await enforceCaps(uid, 'radar');

    const db = admin.firestore();

    // Get profile
    const profileDoc = await db.collection('profiles').doc(profileId).get();
    if (!profileDoc.exists || profileDoc.data()?.uid !== uid) {
      throw new functions.https.HttpsError('not-found', 'Profile not found');
    }

    const profileData = profileDoc.data()!;

    // Get last 30 days of notes (bounded to 80 for cost control)
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const notesSnapshot = await db
      .collection('notes')
      .where('uid', '==', uid)
      .where('profile_id', '==', profileId)
      .where('ts', '>=', thirtyDaysAgo)
      .orderBy('ts', 'desc')
      .limit(80)
      .get();

    const notes = notesSnapshot.docs.map(doc => doc.data());

    // Extract signals from notes
    const signals = extractSignals(notes);

    // Calculate base score using rules
    const baseScore = rulesScore(profileData, signals);

    // Build prompt for LLM refinement
    const prompt = buildRadarPrompt(profileData, signals, baseScore);

    // Call OpenAI for refined analysis
    const completion = await openai.chat.completions.create({
      model: 'gpt-3.5-turbo', // Use cheaper model for cost control
      messages: [
        {
          role: 'system',
          content: 'You are a private relationship mentor for singles only. You analyze patterns from the user\'s observations to flag concerns and suggest small, testable actions. Be concise, respectful, and emotionally intelligent. Never pretend to "know" the other person — only infer from the user\'s inputs. Avoid therapy/medical claims. Keep replies under 120 words unless generating a report.',
        },
        {
          role: 'user',
          content: prompt,
        },
      ],
      max_tokens: 300,
      temperature: 0.7,
    });

    const llmResponse = completion.choices[0]?.message?.content;
    if (!llmResponse) {
      throw new functions.https.HttpsError('internal', 'Failed to get AI response');
    }

    // Parse LLM response
    let radarData;
    try {
      radarData = JSON.parse(llmResponse);
      RadarResponse.parse(radarData); // Validate structure
    } catch (error) {
      // Fallback to rule-based if LLM response is invalid
      radarData = {
        compatibility: baseScore.compatibility,
        pillars: baseScore.pillars,
        flags: baseScore.flags.slice(0, 3).map(flag => ({
          key: flag,
          why: 'Pattern detected from recent observations',
        })),
        strengths: baseScore.strengths.slice(0, 3).map(strength => ({
          key: strength,
          why: 'Positive pattern observed',
        })),
        next_step: baseScore.nextStep,
        short_summary: 'Analysis based on recent patterns and observations',
      };
    }

    // Merge LLM insights with rule-based score
    const finalRadar = {
      ...radarData,
      compatibility: Math.round((baseScore.compatibility + radarData.compatibility) / 2),
      pillars: {
        values: Math.round((baseScore.pillars.values + radarData.pillars.values) / 2),
        emotional_safety: Math.round((baseScore.pillars.emotional_safety + radarData.pillars.emotional_safety) / 2),
        effort_consistency: Math.round((baseScore.pillars.effort_consistency + radarData.pillars.effort_consistency) / 2),
        consistency_words_actions: Math.round((baseScore.pillars.consistency_words_actions + radarData.pillars.consistency_words_actions) / 2),
      },
    };

    // Update profile with new radar data
    const batch = db.batch();
    
    const profileRef = db.collection('profiles').doc(profileId);
    batch.update(profileRef, {
      compatibility: {
        score_0_100: finalRadar.compatibility,
        last_scored_ts: admin.firestore.FieldValue.serverTimestamp(),
      },
      pillars: finalRadar.pillars,
      flags: finalRadar.flags.map(f => f.key),
      strengths: finalRadar.strengths.map(s => s.key),
      next_step: {
        text: finalRadar.next_step,
        due_date: null,
      },
      last_summary: {
        short: finalRadar.short_summary,
        ts: admin.firestore.FieldValue.serverTimestamp(),
      },
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update analytics collection for fast rendering
    const analyticsRef = db.collection('analytics').doc(profileId);
    batch.set(analyticsRef, {
      uid,
      profile_id: profileId,
      compatibility: finalRadar.compatibility,
      pillars: finalRadar.pillars,
      flags: finalRadar.flags,
      strengths: finalRadar.strengths,
      next_step: {
        text: finalRadar.next_step,
        due_date: null,
      },
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();

    // Increment usage
    await incrementUsage(uid, 1);

    return finalRadar;
  } catch (error) {
    console.error('Error in analyzeRedFlags:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError('internal', 'An error occurred while analyzing red flags');
  }
};
