import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSettingsSection(
            context,
            'Account',
            [
              _buildSettingsItem(
                context,
                Icons.person_outline,
                'Profile',
                'Name, photo, preferences',
                () => context.push('/settings/profile'),
              ),
              _buildSettingsItem(
                context,
                Icons.star_outline,
                'Subscription',
                'Manage your plan',
                () => context.push('/settings/subscription'),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildSettingsSection(
            context,
            'Preferences',
            [
              _buildSettingsItem(
                context,
                Icons.notifications_outline,
                'Notifications',
                'Daily check-ins, reminders',
                () => context.push('/settings/notifications'),
              ),
              _buildSettingsItem(
                context,
                Icons.security_outlined,
                'Privacy & Security',
                'Data export, account deletion',
                () => context.push('/settings/privacy'),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildSettingsSection(
            context,
            'Support',
            [
              _buildSettingsItem(
                context,
                Icons.help_outline,
                'Help & Support',
                'Contact us, FAQ',
                () {},
              ),
              _buildSettingsItem(
                context,
                Icons.info_outline,
                'About',
                'Version, legal',
                () {},
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Sign out button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.redFlag.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.redFlag.withOpacity(0.3)),
            ),
            child: TextButton(
              onPressed: () {
                // TODO: Implement sign out
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: AppTheme.redFlag,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.mediumGray,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppTheme.primaryGold,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.whiteText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.mediumGray,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
