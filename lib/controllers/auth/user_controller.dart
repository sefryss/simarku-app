import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/repository/auth/user_repository.dart';
import 'package:simarku/utils/loaders/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First check RX user and then check if user data is already stored.
      await fetchUserRecord();

      // If no record already stored
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            fullName: userCredential.user!.displayName ?? '',
            nikNumber: '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            address: '',
            email: userCredential.user!.email ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      SMLoaders.warningSnackBar(
          title: 'Data gagal tersimpan',
          message:
              'Terjadi kesalahan ketika mencoba menyimpan informasi kamu. Kamu bisa menyimpan ulang data kamu di profil kamu.');
    }
  }

  /// Upload Profile Image
  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateUserField(json);

        user.value.profilePicture = imageUrl;
        SMLoaders.successSnackBar(
            title: 'Selamat!', message: 'Foto profil Kamu berhasil diperbarui');
      }
    } catch (e) {
      SMLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Terjadi kesalahan $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
