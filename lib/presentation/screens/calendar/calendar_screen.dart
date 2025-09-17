import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: TextStyle(color: AppTheme.whiteText),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.timeline, color: AppTheme.primaryGold),
            onPressed: () {
              // Navigate to memory timeline
            },
          ),
        ],
      ),
      body: Center(
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
                Icons.calendar_today,
                size: 40,
                color: AppTheme.primaryGold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Calendar & Memories',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.whiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track important dates and save memories',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.mediumGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
