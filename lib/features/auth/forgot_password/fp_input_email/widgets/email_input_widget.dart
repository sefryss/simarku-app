import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/forget_password_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class FPEmailInputWidget extends StatelessWidget {
  const FPEmailInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Form(
      key: controller.forgetPasswordFormKey,
      child: SMTextField(
        validator: (value) => SMValidator.validateEmail(value),
        controller: controller.email,
        labelText: 'Email',
        labelColor: AppColors.neutralBlack,
        hintText: 'Masukkan Email',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enabledBorderColor: AppColors.neutral04,
      ),
    );
  }
}
