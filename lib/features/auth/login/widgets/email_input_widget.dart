import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/login_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class LoginEmailInputWidget extends StatelessWidget {
  const LoginEmailInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SMTextField(
      validator: (value) => SMValidator.validateEmail(value),
      controller: controller.email,
      labelText: 'Email',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Email',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
