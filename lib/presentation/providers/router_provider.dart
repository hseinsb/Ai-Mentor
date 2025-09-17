import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/mentor/mentor_home_screen.dart';
import '../screens/mentor/add_person_screen.dart';
import '../screens/mentor/person_detail_screen.dart';
import '../screens/mentor/crisis_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/calendar/memory_timeline_screen.dart';
import '../screens/guides/guides_screen.dart';
import '../screens/guides/guide_reader_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/profile_settings_screen.dart';
import '../screens/settings/notification_settings_screen.dart';
import '../screens/settings/subscription_screen.dart';
import '../screens/settings/privacy_settings_screen.dart';
import '../screens/main_navigation_screen.dart';
import 'auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final isOnboardingComplete = ref.watch(isOnboardingCompleteProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isOnSplash = state.matchedLocation == '/splash';
          final isOnAuth = state.matchedLocation.startsWith('/auth');
          final isOnOnboarding = state.matchedLocation == '/onboarding';

          // If on splash, stay there while loading
          if (isOnSplash) return null;

          // If not logged in, redirect to sign in
          if (!isLoggedIn) {
            return isOnAuth ? null : '/auth/sign-in';
          }

          // If logged in but onboarding not complete, redirect to onboarding
          if (!isOnboardingComplete) {
            return isOnOnboarding ? null : '/onboarding';
          }

          // If logged in and onboarding complete, redirect away from auth screens
          if (isOnAuth || isOnOnboarding) {
            return '/mentor';
          }

          return null;
        },
        loading: () => '/splash',
        error: (error, stack) => '/auth/sign-in',
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/auth/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(child: child),
        routes: [
          GoRoute(
            path: '/mentor',
            builder: (context, state) => const MentorHomeScreen(),
            routes: [
              GoRoute(
                path: 'add-person',
                builder: (context, state) => const AddPersonScreen(),
              ),
              GoRoute(
                path: 'person/:profileId',
                builder: (context, state) => PersonDetailScreen(
                  profileId: state.pathParameters['profileId']!,
                ),
              ),
              GoRoute(
                path: 'crisis',
                builder: (context, state) => const CrisisScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
            routes: [
              GoRoute(
                path: 'timeline',
                builder: (context, state) => const MemoryTimelineScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/guides',
            builder: (context, state) => const GuidesScreen(),
            routes: [
              GoRoute(
                path: 'reader/:guideId',
                builder: (context, state) => GuideReaderScreen(
                  guideId: state.pathParameters['guideId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'profile',
                builder: (context, state) => const ProfileSettingsScreen(),
              ),
              GoRoute(
                path: 'notifications',
                builder: (context, state) => const NotificationSettingsScreen(),
              ),
              GoRoute(
                path: 'subscription',
                builder: (context, state) => const SubscriptionScreen(),
              ),
              GoRoute(
                path: 'privacy',
                builder: (context, state) => const PrivacySettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
