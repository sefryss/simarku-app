import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/verify_email_controller.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/global/app_colors.dart';
import 'package:simarku/utils/global/app_text_style.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({
    super.key,
    this.email,
  });

  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthRepository.instance.logout(),
              icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(
                  'assets/animations/verify_email.gif',
                ),
                width: MediaQuery.of(Get.context!).size.width * 0.8,
              ),
              const SizedBox(
                height: 32,
              ),

              /// Title
              Text(
                'Konfirmasi Email Kamu',
                textAlign: TextAlign.center,
                style: AppTextStyle.heading4SemiBold,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                email ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyle.body2Medium,
              ),
              const SizedBox(
                height: 16,
              ),

              /// Sub Title
              Text(
                'Selamat! Akun Kamu Menanti: Konfirmasi Email Kamu untuk memulai dan mencari buku yang kamu inginkan. Serta dapat melakukan Tukar Pinjam, Tukar Milik, dan juga Donasi Buku',
                textAlign: TextAlign.center,
                style: AppTextStyle.body3Regular
                    .copyWith(color: AppColors.neutral06),
              ),
              const SizedBox(
                height: 24,
              ),

              /// Button
              SMElevatedButton(
                onPressed: () => controller.checkEmailVerificationStatus(),
                labelText: 'Lanjutkan',
                width: double.infinity,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
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
