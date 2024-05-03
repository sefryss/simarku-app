import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simarku/controllers/auth/forget_password_controller.dart';
import 'package:simarku/features/auth/login/screen/login_page.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            56 * 2,
            24,
            0,
          ),
          child: Column(
            children: [
              /// Image
              /// Image
              // Image(
              //   image: AssetImage(
              //     'assets/animations/success_animation.gif',
              //   ),
              //   width: MediaQuery.of(Get.context!).size.width * 0.8,
              // ),
              Lottie.asset(
                'assets/animations/success.json',
                width: MediaQuery.of(Get.context!).size.width * 0.8,
              ),
              const SizedBox(
                height: 32,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                email,
                textAlign: TextAlign.center,
                style: AppTextStyle.body2Medium,
              ),
              const SizedBox(
                height: 16,
              ),

              /// Title
              Text(
                'Email Lupa Kata Sandi Terkirim',
                textAlign: TextAlign.center,
                style: AppTextStyle.heading4SemiBold,
              ),

              const SizedBox(
                height: 16,
              ),

              /// Sub Title
              Text(
                'Keamanan Akun Anda adalah Prioritas Kami! Kami telah mengirimkan tautan aman kepada Anda untuk mengubah kata sandi Anda dengan aman dan menjaga akun Anda tetap terlindungi.',
                textAlign: TextAlign.center,
                style: AppTextStyle.body3Regular
                    .copyWith(color: AppColors.neutral06),
              ),
              const SizedBox(
                height: 24,
              ),

              /// Button
              SMElevatedButton(
                onPressed: () => Get.offAll(() => const LoginPage()),
                labelText: 'Lanjutkan',
                width: double.infinity,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance
                      .resendPasswordResetEmail(email),
                  child: Text('Kirim Ulang',
                      style: AppTextStyle.paragraphMedium
                          .copyWith(color: AppColors.primary)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
