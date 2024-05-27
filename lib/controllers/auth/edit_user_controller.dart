import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/user_controller.dart';
import 'package:simarku/features/home/home_page.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/repository/auth/user_repository.dart';
import 'package:simarku/utils/loaders/full_screen_loader.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/network/network_manager.dart';

class EditUserController extends GetxController {
  static EditUserController get instance => Get.find();

  final fullName = TextEditingController();
  final nikNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> editUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    fullName.text = userController.user.value.fullName;
    nikNumber.text = userController.user.value.nikNumber;
    phoneNumber.text = userController.user.value.phoneNumber;
    address.text = userController.user.value.address;
    email.text = userController.user.value.email;
  }

  Future<void> updateUser() async {
    try {
      // Start Loading
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }
      // Form Validate
      if (!editUserFormKey.currentState!.validate()) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      // Update User in the Firebase & Firestore
      Map<String, dynamic> user = {
        'FullName': fullName.text.trim(),
        'NIKNumber': nikNumber.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        'Address': address.text.trim(),
        'Email': email.text.trim(),
        //   'ProfilePicture': profilePicture,
      };

      await userRepository.updateUserField(user);

      // Update the RX user Value
      UserModel updatedUser = userController.user.value.copyWith(
        fullName: fullName.text.trim(),
        nikNumber: nikNumber.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        address: address.text.trim(),
        email: email.text.trim(),
      );

      userController.user.value = updatedUser;

      // Remove Loader
      SMFullScreenLoader.stopLoading();

      // Show Success Message
      SMLoaders.successSnackBar(
          title: 'Selamat', message: 'Profil Kamu berhasil diubah!');

      // Move to Previouse Screen
      Get.off(() => const NavigationMenu());
    } catch (e) {
        print(e);
      SMFullScreenLoader.stopLoading();
      SMLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
