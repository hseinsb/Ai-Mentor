import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final authService = ref.watch(authServiceProvider);
  
  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);
      return authService.getCurrentUserData(user.uid);
    },
    loading: () => Stream.value(null),
    error: (error, stack) => Stream.value(null),
  );
});

final isOnboardingCompleteProvider = Provider<bool>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser.when(
    data: (user) => user?.quickWinDone ?? false,
    loading: () => false,
    error: (error, stack) => false,
  );
});
