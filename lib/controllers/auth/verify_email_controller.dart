import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/register/widgets/success_screen.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/loaders/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send email whenever verify screen appears & set timer to auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimeForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthRepository.instance.sendEmailVerification();
      SMLoaders.successSnackBar(
          title: 'Email Terkirim',
          message: 'Tolong cek inbox kamu dan konfirmasi email kamu.');
    } catch (e) {
      SMLoaders.errorSnackBar(title: 'Oops', message: e.toString());
    }
  }

  /// Timer to Automatically Redirect on Email Verification
  setTimeForAutoRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              onPressed: () => AuthRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  /// Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            onPressed: () => AuthRepository.instance.screenRedirect(),
          ));
    }
  }
}
