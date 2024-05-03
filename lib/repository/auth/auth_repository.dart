import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simarku/features/auth/register/widgets/verify_email.dart';
import 'package:simarku/utils/exceptions/exceptions.dart';
import 'package:simarku/features/auth/login/screen/login_page.dart';
import 'package:simarku/features/home/home_page.dart';
import 'package:simarku/features/onboarding/screens/onboarding_page.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final deviceStorage = GetStorage();

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmail(email: _auth.currentUser?.email));
      }
    } else {
      // Controll Onboarding Only One Time
      // Check if IsFirstTime exists, otherwise create it with true
      await deviceStorage.writeIfNull('IsFirstTime', true);

      // Update navigation based on IsFirstTime value
      if (deviceStorage.read('IsFirstTime') != true) {
        Get.offAll(() => LoginPage()); // Go to Login Page
      } else {
        Get.offAll(() => OnboardingPage()); // Go to Onboarding Page
      }

      // Update IsFirstTime to false after first redirection
      await deviceStorage.write('IsFirstTime', false);
    }
  }

/*-----------------------------  Email & Password SIgn In ----------------------------*/

  /// [EmailAuthentication] - SIGN IN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      throw SMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.code}');
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('FormatException occurred');
      throw SMFormatException();
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code}');
      throw SMPlatformException(e.code).message;
    } catch (e) {
      print('An error occurred: $e');
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //   firebaseUser.value != null
      //       ? Get.offAll(() => const LoginPage())
      //       : Get.to(() => RegisterPage());
    } on FirebaseAuthException catch (e) {
      throw SMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  /// [EmailAuthentication] -MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  /// [ReAuthentication] - RE AUTHENTICATION USER

  /// [LogoutUser] - LOGOUT
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      throw SMFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }
}
