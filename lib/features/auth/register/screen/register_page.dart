import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/features/auth/register/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      // appBar: AppBar(
      //   leading: SMBackButton(buttonColor: AppColors.primary,),
      // ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(
          16.0,
          24.0,
          16.0,
          16.0,
        ),
        children: [
          Text(
            'Daftar',
            textAlign: TextAlign.center,
            style:
                AppTextStyle.heading5Bold.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Daftarkan Akun Kamu',
            textAlign: TextAlign.center,
            style:
                AppTextStyle.body2Regular.copyWith(color: AppColors.neutral06),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Form(
            key: controller.signupFormKey,
            child: Column(
              children: [
                RegisterNameInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterNIKInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterPhoneInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterAddressInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterEmailInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterPasswordInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                RegisterConfirmPasswordInputWidget(
                  password: controller.password.text,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TnC(),
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          RegisterSubmitButton(),
          const SizedBox(
            height: 32.0,
          ),
          LoginButton(),
        ],
      )),
    );
  }
}
