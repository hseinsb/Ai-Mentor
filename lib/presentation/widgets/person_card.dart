import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final int compatibility;
  final List<String> flags;
  final String lastUpdated;
  final Color avatarColor;
  final VoidCallback onTap;

  const PersonCard({
    super.key,
    required this.name,
    required this.compatibility,
    required this.flags,
    required this.lastUpdated,
    required this.avatarColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.darkGray.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: avatarColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: avatarColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      name.substring(0, 1).toUpperCase(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: avatarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Name and last updated
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Last updated $lastUpdated',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Compatibility ring
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          value: compatibility / 100,
                          strokeWidth: 4,
                          backgroundColor: AppTheme.darkGray,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getCompatibilityColor(compatibility),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '$compatibility%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.whiteText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            if (flags.isNotEmpty) ...[
              const SizedBox(height: 16),
              // Flag chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: flags.take(3).map((flag) => _buildFlagChip(flag)).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFlagChip(String flag) {
    final displayText = _getFlagDisplayText(flag);
    final color = _getFlagColor(flag);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getCompatibilityColor(int score) {
    if (score >= 70) return AppTheme.greenStrength;
    if (score >= 40) return AppTheme.warningOrange;
    return AppTheme.redFlag;
  }

  Color _getFlagColor(String flag) {
    switch (flag) {
      case 'low_effort':
      case 'disrespect':
      case 'inconsistency':
        return AppTheme.redFlag;
      case 'avoidance':
      case 'jealousy_control':
        return AppTheme.warningOrange;
      default:
        return AppTheme.mediumGray;
    }
  }

  String _getFlagDisplayText(String flag) {
    switch (flag) {
      case 'low_effort':
        return 'Low Effort';
      case 'disrespect':
        return 'Disrespect';
      case 'avoidance':
        return 'Avoidance';
      case 'jealousy_control':
        return 'Control Issues';
      case 'inconsistency':
        return 'Inconsistent';
      default:
        return flag;
    }
  }
}
