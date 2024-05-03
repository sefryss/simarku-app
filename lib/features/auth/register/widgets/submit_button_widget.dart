import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';

import 'package:simarku/utils/global/app_config.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
         

          controller.signup();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Daftar",
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


          //   SignUpController.instance.registerUser(
          //       controller.email.text.trim(), controller.password.text.trim());