import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/edit_user_controller.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';



class ProfileAddressInputWidget extends StatelessWidget {
  const ProfileAddressInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditUserController());
    return SMTextField(
      validator: (value) =>
          SMValidator.validateEmptyField('Alamat Lengkap', value),
      controller: controller.address,
      labelText: 'Alamat Lengkap',
      labelColor: AppColors.neutralBlack,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
