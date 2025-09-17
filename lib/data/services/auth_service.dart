import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../../core/constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Create account with email and password
  Future<UserCredential> createAccountWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create initial user document
      if (credential.user != null) {
        await _createInitialUserDocument(credential.user!);
      }
      
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      // Create user document if new user
      if (userCredential.additionalUserInfo?.isNewUser == true && userCredential.user != null) {
        await _createInitialUserDocument(userCredential.user!);
      }
      
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      
      // Create user document if new user
      if (userCredential.additionalUserInfo?.isNewUser == true && userCredential.user != null) {
        await _createInitialUserDocument(userCredential.user!);
      }
      
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  // Get current user data
  Stream<UserModel?> getCurrentUserData(String uid) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromJson({
        ...doc.data()!,
        'uid': doc.id,
      });
    });
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .update({
        ...data,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Complete onboarding
  Future<void> completeOnboarding(String uid, Map<String, dynamic> onboardingData) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .update({
        ...onboardingData,
        'quick_win_done': true,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Create initial user document
  Future<void> _createInitialUserDocument(User user) async {
    final now = DateTime.now();
    final userData = UserModel(
      uid: user.uid,
      displayName: user.displayName ?? '',
      avatarUrl: user.photoURL ?? '',
      tonePref: AppConstants.balancedTone,
      plan: AppConstants.freePlan,
      usage: const UsageModel(),
      caps: const CapsModel(
        dailyLimit: AppConstants.freeDailyLimit,
        monthlyLimit: AppConstants.freeMonthlyLimit,
      ),
      commitments: const CommitmentsModel(),
      notificationPrefs: const NotificationPrefsModel(),
      privacy: const PrivacyModel(),
      quickWinDone: false,
      createdAt: now,
      updatedAt: now,
    );

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.uid)
        .set(userData.toJson());
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Delete user document
        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(user.uid)
            .delete();
        
        // Delete Firebase Auth account
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
