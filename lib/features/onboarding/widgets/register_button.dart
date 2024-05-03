import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/register/screen/register_page.dart';
import '../../../utils/global/app_config.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Get.to(() => RegisterPage()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Buat Akun",
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
