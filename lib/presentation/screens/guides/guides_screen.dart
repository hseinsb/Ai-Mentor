import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';

class GuidesScreen extends ConsumerWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Guides',
          style: TextStyle(color: AppTheme.whiteText),
        ),
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
                Icons.menu_book,
                size: 40,
                color: AppTheme.primaryGold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '15-Step Relationship Guide',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.whiteText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Master the art of healthy relationships',
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
