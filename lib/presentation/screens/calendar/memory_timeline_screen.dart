import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MemoryTimelineScreen extends StatelessWidget {
  const MemoryTimelineScreen({super.key});

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
          'Memory Timeline',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Center(
        child: Text(
          'Memory Timeline Coming Soon',
          style: TextStyle(color: AppTheme.mediumGray),
        ),
      ),
    );
  }
}
