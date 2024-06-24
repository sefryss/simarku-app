import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simarku/controllers/chat/chat_controller.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/repository/auth/user_repository.dart';
import 'package:simarku/utils/loaders/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final time = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final fetchedUser = await userRepository.fetchUserDetails();
      user(fetchedUser);

      // Update active status
      await ChatController.updateActiveStatus(true);

      // Update push token
      await updatePushToken();
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
          final newUser = UserModel(
            id: userCredential.user!.uid,
            fullName: userCredential.user!.displayName ?? '',
            nikNumber: '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            address: '',
            email: userCredential.user!.email ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
            deviceId: '',
            isAccess: false,
            isAdmin: false,
            isOnline: false,
            lastActive: time,
            pushToken: '',
          );

          // Save user data
          await userRepository.saveUserRecord(newUser);

          // Fetch user details to get the updated user data
          await fetchUserRecord();

          // Update push token
          await updatePushToken();
        }
      }
    } catch (e) {
      SMLoaders.warningSnackBar(
          title: 'Data gagal tersimpan',
          message:
              'Terjadi kesalahan ketika mencoba menyimpan informasi kamu. Kamu bisa menyimpan ulang data kamu di profil kamu.');
    }
  }

  // Function to update Firebase Messaging Token
  Future<void> updatePushToken() async {
    try {
      final token = await userRepository.fetchFirebaseMessagingToken();
      await userRepository.updateUserField({'PushToken': token});
      user.value.pushToken = token;

      //   // for handling foreground messages
      //   await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //     log('Got a message whilst in the foreground!');
      //     log('Message data: ${message.data}');

      //     if (message.notification != null) {
      //       log('Message also contained a notification: ${message.notification}');
      //     }
      //   });
    } catch (e) {
      SMLoaders.errorSnackBar(
          title: 'Push Token Error',
          message: 'Terjadi kesalahan mendapatkan push token.');
    }
  }

//   // Update active status
//   Future<void> updateActiveStatus(bool isActive) async {
//     try {
//       await userRepository.updateUserField({'IsOnline': isActive});
//       user.value.isOnline = isActive;
//     } catch (e) {
//       SMLoaders.errorSnackBar(
//           title: 'Status Error', message: 'Terjadi kesalahan memperbarui status aktif.');
//     }
//   }

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
      SMLoaders.errorSnackBar(title: 'Oops', message: 'Terjadi kesalahan $e');
    } finally {
      imageUploading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      // Update active status to false
      await ChatController.updateActiveStatus(false);
      await FirebaseAuth.instance.signOut();
      user(UserModel.empty());
    } catch (e) {
      SMLoaders.errorSnackBar(
          title: 'Logout Failed', message: 'Terjadi kesalahan saat logout.');
    }
  }
}
