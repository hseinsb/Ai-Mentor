import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
          'Subscription',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Center(
        child: Text(
          'Subscription Management Coming Soon',
          style: TextStyle(color: AppTheme.mediumGray),
        ),
      ),
    );
  }
}
