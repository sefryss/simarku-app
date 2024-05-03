import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/login_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class LoginPasswordInputWidget extends StatelessWidget {
  const LoginPasswordInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Obx(
      () => SMTextField(
        validator: (value) => SMValidator.validateEmptyField('Password', value),
        controller: controller.password,
        labelText: 'Kata Sandi',
        labelColor: AppColors.neutralBlack,
        hintText: 'Masukkan Kata Sandi',
        obscureText: controller.hidePassword.value,
        suffixIcon: IconButton(
          iconSize: 18.0,
          onPressed: () =>
              controller.hidePassword.value = !controller.hidePassword.value,
          icon: Icon(
            controller.hidePassword.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey,
          ),
          focusNode: FocusNode(skipTraversal: true), // skip focus
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        enabledBorderColor: AppColors.neutral04,
      ),
    );
  }

  //  String? _getErrorMessage(Password validation) {
  //   if (validation.invalid) {
  //     if (validation.error == PasswordValidationError.empty) {
  //       return 'Kata sandi harus di isi';
  //     }
  //     if (validation.error == PasswordValidationError.invalid) {
  //       return 'Minimal 8 karakter serta gunakan kombinasi huruf besar kecil dan angka';
  //     }
  //   }
  //   return null;
  // }
}
