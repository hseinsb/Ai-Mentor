import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { analyzeRedFlags } from './ai/analyze-red-flags';
import { mentorChat } from './ai/mentor-chat';
import { weeklySummary } from './ai/weekly-summary';
import { generateReport } from './ai/generate-report';
import { adminResetUsage } from './admin/reset-usage';

// Initialize Firebase Admin
admin.initializeApp();

// AI Processing Functions
export const analyzeRedFlagsFunction = functions.https.onCall(analyzeRedFlags);
export const mentorChatFunction = functions.https.onCall(mentorChat);
export const weeklySummaryFunction = functions.https.onCall(weeklySummary);
export const generateReportFunction = functions.https.onCall(generateReport);

// Admin Functions
export const adminResetUsageFunction = functions.https.onCall(adminResetUsage);

// Scheduled Functions
export const dailyUsageReset = functions.pubsub
  .schedule('0 0 * * *') // Daily at midnight UTC
  .timeZone('UTC')
  .onRun(async (context) => {
    const db = admin.firestore();
    const batch = db.batch();
    
    const usersSnapshot = await db.collection('users').get();
    
    usersSnapshot.docs.forEach((doc) => {
      const userRef = db.collection('users').doc(doc.id);
      batch.update(userRef, {
        'usage.daily_replies_used': 0,
        'usage.last_reset_ts': admin.firestore.FieldValue.serverTimestamp(),
        'updated_at': admin.firestore.FieldValue.serverTimestamp(),
      });
    });
    
    await batch.commit();
    console.log('Daily usage reset completed');
  });

export const monthlyUsageReset = functions.pubsub
  .schedule('0 0 1 * *') // First day of each month at midnight UTC
  .timeZone('UTC')
  .onRun(async (context) => {
    const db = admin.firestore();
    const batch = db.batch();
    
    const usersSnapshot = await db.collection('users').get();
    
    usersSnapshot.docs.forEach((doc) => {
      const userRef = db.collection('users').doc(doc.id);
      batch.update(userRef, {
        'usage.monthly_replies_used': 0,
        'usage.last_reset_ts': admin.firestore.FieldValue.serverTimestamp(),
        'updated_at': admin.firestore.FieldValue.serverTimestamp(),
      });
    });
    
    await batch.commit();
    console.log('Monthly usage reset completed');
  });
