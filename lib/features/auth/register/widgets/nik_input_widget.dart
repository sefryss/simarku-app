import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class RegisterNIKInputWidget extends StatelessWidget {
  const RegisterNIKInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SMTextField(
              validator: (value) =>
          SMValidator.validateEmptyField('Nomor Identitas', value),
      controller: controller.nikNumber,
      labelText: 'Nomor Identitas / NIK',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Nomor Identitas',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
