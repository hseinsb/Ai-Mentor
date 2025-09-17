import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GuideReaderScreen extends StatelessWidget {
  final String guideId;

  const GuideReaderScreen({
    super.key,
    required this.guideId,
  });

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
          'Guide Reader',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Center(
        child: Text(
          'Guide $guideId Reader Coming Soon',
          style: TextStyle(color: AppTheme.mediumGray),
        ),
      ),
    );
  }
}
