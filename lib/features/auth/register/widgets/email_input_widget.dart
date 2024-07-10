import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class RegisterEmailInputWidget extends StatelessWidget {
  const RegisterEmailInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SMTextField(
      validator: (value) => SMValidator.validateEmail(value),
      controller: controller.email,
      labelText: 'Email',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Email',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
