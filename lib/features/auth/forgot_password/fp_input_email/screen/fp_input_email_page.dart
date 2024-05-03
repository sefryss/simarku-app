import 'package:flutter/material.dart';
import 'package:simarku/features/auth/forgot_password/fp_input_email/widgets/widgets.dart';

import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class FPInputEmailPage extends StatelessWidget {
  const FPInputEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SMBackButton(
          buttonColor: AppColors.primary,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          children: [
            Text(
              'Lupa Kata Sandi',
              textAlign: TextAlign.center,
              style: AppTextStyle.heading5Bold
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Ubah Kata Sandi Kamu',
              textAlign: TextAlign.center,
              style: AppTextStyle.body2Regular
                  .copyWith(color: AppColors.neutral06),
            ),
            const SizedBox(
              height: 32.0,
            ),
            FPEmailInputWidget(),
            const SizedBox(
              height: 24,
            ),
            FPButton()
          ],
        ),
      ),
    );
  }
}
