import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class RegisterNameInputWidget extends StatelessWidget {
  const RegisterNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SMTextField(
              validator: (value) =>
          SMValidator.validateEmptyField('Nama Lengkap', value),
      controller: controller.fullName,
      labelText: 'Nama Pengguna',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Nama Lengkap',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
