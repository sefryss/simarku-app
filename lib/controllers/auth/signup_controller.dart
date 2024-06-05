import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/register/widgets/verify_email.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/repository/auth/user_repository.dart';
import 'package:simarku/utils/loaders/full_screen_loader.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/network/network_manager.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Textfield controllers untuk get data dari textfield
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = false.obs;
  final fullName = TextEditingController();
  final nikNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController(text: '');
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }
      // Form Validate
      if (!signupFormKey.currentState!.validate()) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        SMLoaders.warningSnackBar(
            title: 'Terima Kebijakan Privasi',
            message:
                'Untuk membuat akun, kamu harus membaca dan menyetujui Syarat dan Ketentuan serta Kebijakan Privasi');
        SMFullScreenLoader.stopLoading();
        return; // Tidak lanjut jika belum setuju kebijakan privasi
      }

      // Register user in Firebase Authentication & Save user data in Firebase
      final userCredential = await AuthRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authentication user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        fullName: fullName.text.trim(),
        nikNumber: nikNumber.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        address: address.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop Loading
      SMFullScreenLoader.stopLoading();
      // Show Success Message
      SMLoaders.successSnackBar(
          title: 'Selamat',
          message:
              'Akun kamu berhasil dibuat! Konfirmasi email untuk melanjutkan');

      // Move to Verify Email Screen
      Get.to(() => VerifyEmail(email: email.text.trim()));
    } catch (e) {
      SMFullScreenLoader.stopLoading();
      SMLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}
