import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/app_button.dart';

class CrisisScreen extends StatelessWidget {
  const CrisisScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Crisis Support',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.redFlag.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.redFlag.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppTheme.redFlag),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'If you feel unsafe, trust your instincts and prioritize your safety.',
                      style: TextStyle(color: AppTheme.whiteText),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            Text(
              'How can I help?',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppTheme.whiteText,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 24),
            
            ...AppConstants.crisisTypes.map((type) => _buildCrisisOption(
              context,
              type,
              _getCrisisIcon(type),
              _getCrisisDescription(type),
            )),
            
            const Spacer(),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Resources',
                    style: TextStyle(
                      color: AppTheme.whiteText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'If you are in immediate danger, call emergency services (911).',
                    style: TextStyle(color: AppTheme.mediumGray),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Find Local Resources',
                    onPressed: () {
                      // Open local resources
                    },
                    isOutlined: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrisisOption(BuildContext context, String type, IconData icon, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _handleCrisisType(context, type),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.darkGray.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getCrisisColor(type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: _getCrisisColor(type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
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
      ),
    );
  }

  IconData _getCrisisIcon(String type) {
    switch (type) {
      case 'Anxious':
        return Icons.psychology;
      case 'Confused':
        return Icons.help_outline;
      case 'Unsafe':
        return Icons.shield;
      case 'Boundary needed':
        return Icons.block;
      case 'Apology needed':
        return Icons.chat_bubble_outline;
      default:
        return Icons.help;
    }
  }

  String _getCrisisDescription(String type) {
    switch (type) {
      case 'Anxious':
        return 'Feeling overwhelmed or worried about the situation';
      case 'Confused':
        return 'Unsure about their behavior or your feelings';
      case 'Unsafe':
        return 'Feeling threatened or in potential danger';
      case 'Boundary needed':
        return 'Need help setting or enforcing a boundary';
      case 'Apology needed':
        return 'Help crafting an appropriate response or apology';
      default:
        return 'Get immediate guidance and support';
    }
  }

  Color _getCrisisColor(String type) {
    switch (type) {
      case 'Anxious':
        return AppTheme.warningOrange;
      case 'Confused':
        return AppTheme.primaryGold;
      case 'Unsafe':
        return AppTheme.redFlag;
      case 'Boundary needed':
        return AppTheme.primaryGold;
      case 'Apology needed':
        return AppTheme.greenStrength;
      default:
        return AppTheme.mediumGray;
    }
  }

  void _handleCrisisType(BuildContext context, String type) {
    // TODO: Implement specific crisis handling flows
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkSurface,
        title: Text(
          type,
          style: TextStyle(color: AppTheme.whiteText),
        ),
        content: Text(
          'Crisis support for "$type" will be implemented here with specific guidance and resources.',
          style: TextStyle(color: AppTheme.mediumGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppTheme.primaryGold),
            ),
          ),
        ],
      ),
    );
  }
}
