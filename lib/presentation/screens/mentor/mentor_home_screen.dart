import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/person_card.dart';
import '../../widgets/app_button.dart';

class MentorHomeScreen extends ConsumerStatefulWidget {
  const MentorHomeScreen({super.key});

  @override
  ConsumerState<MentorHomeScreen> createState() => _MentorHomeScreenState();
}

class _MentorHomeScreenState extends ConsumerState<MentorHomeScreen> {
  int _streakCount = 7; // Example streak count
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Mentor',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: AppTheme.primaryGold,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_streakCount day streak',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primaryGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.push('/mentor/add-person'),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGold,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.darkBackground,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Red Flag Radar CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGold.withOpacity(0.2),
                      AppTheme.primaryGold.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryGold.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.radar,
                            color: AppTheme.primaryGold,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Red Flag Radar',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.whiteText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Get instant insights on compatibility and red flags. Analyze patterns and get actionable next steps.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumGray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: 'Run Radar Check',
                      onPressed: () {
                        // Show person selection or run for most recent person
                        _showRadarBottomSheet();
                      },
                      backgroundColor: AppTheme.primaryGold,
                      textColor: AppTheme.darkBackground,
                      height: 48,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // People list header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'People',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.whiteText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Filter/sort options
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // People list
            Expanded(
              child: _buildPeopleList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleList() {
    // Mock data - in real app this would come from Firestore
    final List<Map<String, dynamic>> people = [
      {
        'id': '1',
        'name': 'Alex',
        'compatibility': 72,
        'flags': ['low_effort', 'avoidance'],
        'lastUpdated': '2 days ago',
        'avatarColor': AppTheme.primaryGold,
      },
      {
        'id': '2',
        'name': 'Jordan',
        'compatibility': 45,
        'flags': ['disrespect', 'inconsistency'],
        'lastUpdated': '1 week ago',
        'avatarColor': AppTheme.redFlag,
      },
      {
        'id': '3',
        'name': 'Sam',
        'compatibility': 89,
        'flags': [],
        'lastUpdated': '3 days ago',
        'avatarColor': AppTheme.greenStrength,
      },
    ];

    if (people.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PersonCard(
            name: person['name'],
            compatibility: person['compatibility'],
            flags: List<String>.from(person['flags']),
            lastUpdated: person['lastUpdated'],
            avatarColor: person['avatarColor'],
            onTap: () => context.push('/mentor/person/${person['id']}'),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.darkGray),
              ),
              child: const Icon(
                Icons.people_outline,
                size: 40,
                color: AppTheme.mediumGray,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No people added yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.whiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start by adding someone you\'re interested in or currently dating',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.mediumGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Add First Person',
              onPressed: () => context.push('/mentor/add-person'),
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  void _showRadarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Run Red Flag Radar',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.whiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Choose someone to analyze:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.mediumGray,
              ),
            ),
            const SizedBox(height: 16),
            
            // List people here
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryGold,
                child: Text(
                  'A',
                  style: TextStyle(
                    color: AppTheme.darkBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              title: Text(
                'Alex',
                style: TextStyle(color: AppTheme.whiteText),
              ),
              subtitle: Text(
                'Last analyzed 2 days ago',
                style: TextStyle(color: AppTheme.mediumGray),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.mediumGray,
                size: 16,
              ),
              onTap: () {
                Navigator.pop(context);
                context.push('/mentor/person/1');
              },
            ),
            
            const SizedBox(height: 16),
            AppButton(
              text: 'Cancel',
              onPressed: () => Navigator.pop(context),
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }
}
