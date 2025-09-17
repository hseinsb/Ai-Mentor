import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';

class PersonDetailScreen extends ConsumerWidget {
  final String profileId;

  const PersonDetailScreen({
    super.key,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Alex', // TODO: Get from profile data
          style: TextStyle(color: AppTheme.whiteText),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.crisis_alert, color: AppTheme.redFlag),
            onPressed: () {
              // Navigate to crisis screen
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                labelColor: AppTheme.primaryGold,
                unselectedLabelColor: AppTheme.mediumGray,
                indicator: BoxDecoration(
                  color: AppTheme.primaryGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                tabs: const [
                  Tab(text: 'Radar'),
                  Tab(text: 'Chat'),
                  Tab(text: 'Notes'),
                ],
              ),
            ),
            
            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  _buildRadarTab(),
                  _buildChatTab(),
                  _buildNotesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compatibility ring
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: 0.72, // 72%
                      strokeWidth: 12,
                      backgroundColor: AppTheme.darkGray,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '72%',
                          style: TextStyle(
                            color: AppTheme.whiteText,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Compatibility',
                          style: TextStyle(
                            color: AppTheme.mediumGray,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Red flags section
          Text(
            'Red Flags',
            style: TextStyle(
              color: AppTheme.whiteText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // TODO: Add flag chips
          
          const SizedBox(height: 24),
          
          // Strengths section
          Text(
            'Strengths',
            style: TextStyle(
              color: AppTheme.whiteText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // TODO: Add strength chips
          
          const SizedBox(height: 24),
          
          // Next step
          Text(
            'Next Step',
            style: TextStyle(
              color: AppTheme.whiteText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Ask them about their long-term relationship goals during your next conversation.',
              style: TextStyle(color: AppTheme.whiteText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Chat feature coming soon',
              style: TextStyle(color: AppTheme.mediumGray),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesTab() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Notes feature coming soon',
              style: TextStyle(color: AppTheme.mediumGray),
            ),
          ),
        ),
      ],
    );
  }
}
