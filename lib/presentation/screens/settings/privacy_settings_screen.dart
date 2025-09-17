import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

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
          'Privacy & Security',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Center(
        child: Text(
          'Privacy Settings Coming Soon',
          style: TextStyle(color: AppTheme.mediumGray),
        ),
      ),
    );
  }
}
