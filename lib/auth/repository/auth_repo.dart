import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stride/utils/exceptions/format_exceptions.dart';
import 'package:stride/utils/exceptions/platform_exceptions.dart';
import '../../screens/navigation_menu.dart';
import '../../screens/splash.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/storage/storage_utility.dart';
import '../forms/login.dart';
import '../forms/verify.dart';
import 'user_repo.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();

    // Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to show relevant screen
  Future<void> screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        // Initialize user-specific storage
        await BLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyMail(email: user.email));
      }
    } else {
      // Local storage check
        deviceStorage.writeIfNull('IsFirstTime', true); 
        // check if it's the first time launching the app - using local storage. 
    deviceStorage.read('IsFirstTime') != true ?
     Get.offAll(() => const LoginScreen()) : 
     Get.offAll(() => const SplashScreen());
        
     
    }
  }

  /// Centralized error handler
  void handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      throw BFirebaseAuthException(e.code).message;
    } else if (e is FirebaseException) {
      throw BFirebaseException(e.code).message;
    } else if (e is FormatException) {
      throw const BFormatException();
    } else if (e is BPlatformException) {
      throw BPlatformException(e.code).message;
    } else {
      throw 'Something went wrong. Please try again';
    }
  }

  /* _____________ Email and Password Validation _____________ */

  /// [EmailAuth] - Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      handleException(e);
    }
    throw 'Login failed'; // Fallback
  }

  /// [EmailAuth] - SignUp
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      handleException(e);
    }
    throw 'Sign-up failed'; // Fallback
  }

  /// [Email Verification]
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      handleException(e);
    }
  }

  /// [LogoutUser] - Logs out from any auth (Google/Firebase)
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      handleException(e);
    }
  }

  /// [Google Auth] - Google Authentication
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      if (userAccount == null) {
        // User canceled the sign-in flow
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await userAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      handleException(e);
    }
    return null; // Fallback
  }

  /// [EmailAuth] - Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      handleException(e);
    }
  }

  /// [ReAuth User]
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser?.reauthenticateWithCredential(credential);
    } catch (e) {
      handleException(e);
    }
  }

  /// [Delete User Account]
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } catch (e) {
      handleException(e);
    }
  }
}
