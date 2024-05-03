import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/forget_password_controller.dart';
import 'package:simarku/features/auth/otp_verification/widgets/widgets.dart';
import 'package:simarku/routes/app_router.dart';
import 'package:simarku/utils/shared_widgets/auth_success_dialog.dart';

import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class FPButton extends StatelessWidget {
  const FPButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return SMElevatedButton(
        onPressed: () => controller.sendPasswordResetEmail(),
        labelText: 'Kirim');
  }
}
