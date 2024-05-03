import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/forgot_password/fp_input_email/widgets/widgets.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/loaders/full_screen_loader.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/network/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        SMFullScreenLoader.stopLoading();
        return;
      }
      // Sent Email to Reset Email
      await AuthRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loaders
      SMFullScreenLoader.stopLoading();
      // Show Success Screen
      SMLoaders.successSnackBar(
          title: 'Email Terkirim',
          message: 'Link Email Terkirim untuk Reset Password Anda'.tr);

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      // Remove Loaders
      SMFullScreenLoader.stopLoading();
      SMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Resend Reset Password Email
  resendPasswordResetEmail(String email) async {
    try {
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      // Sent Email to Reset Email
      await AuthRepository.instance.sendPasswordResetEmail(email);

      // Remove Loaders
      SMFullScreenLoader.stopLoading();
      // Show Success Screen
      SMLoaders.successSnackBar(
          title: 'Email Terkirim',
          message: 'Link Email Terkirim untuk Reset Password Anda'.tr);

      // Redirect
      Get.to(() => ResetPassword(email: email));
    } catch (e) {
      // Remove Loaders
      SMFullScreenLoader.stopLoading();
      SMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
