import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/loaders/full_screen_loader.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/network/network_manager.dart';

class LoginController extends GetxController {
//   static LoginController get instance => Get.find();

  /// Variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    final rememberEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final rememberPassword = localStorage.read('REMEMBER_ME_PASSWORD');
    email.text = rememberEmail ?? ''; // Set to empty string if null
    password.text = rememberPassword ?? ''; // Set to empty string if null
    super.onInit();
  }

  /// Email & Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!loginFormKey.currentState!.validate()) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      //   /// Save RememberMe if selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      /// SLogin User using Email & Password Authentication
      await AuthRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// Remove Loaders
      SMFullScreenLoader.stopLoading();

      /// Redirect
      AuthRepository.instance.screenRedirect();
    } catch (e) {
      SMFullScreenLoader.stopLoading();
      SMLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}
