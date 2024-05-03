import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/auth/otp_verification/widgets/widgets.dart';
import 'package:simarku/routes/app_router.dart';
import 'package:simarku/utils/shared_widgets/auth_success_dialog.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class OTPButton extends StatelessWidget {
  final OTPType pageType;

  const OTPButton({super.key, required this.pageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 32.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: SMElevatedButton(
          onPressed: () {
            pageType == OTPType.registerVertification
                ? showDialog(
                    context: context,
                    builder: (ctx) => AuthSuccessDialog(
                      title: 'Akun Anda Berhasil Didaftarkan',
                      body: 'Silahkan masuk untuk melanjutkan',
                      onPressed: () {
                        // Get.toNamed(Routes.login);
                      },
                      buttonText: 'Masuk',
                    ),
                  )
                  : ();
                // : Get.toNamed(
                //     Routes.fpInputNewPassword,
                //   );
          },
          labelText: 'Selanjutnya',
        ),
      ),
    );
  }
}
