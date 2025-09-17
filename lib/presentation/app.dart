import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/app_constants.dart';
import 'providers/auth_provider.dart';
import 'providers/router_provider.dart';

class AIMentorApp extends ConsumerWidget {
  const AIMentorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark theme as specified
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
