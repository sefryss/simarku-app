import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/login_controller.dart';
import 'package:simarku/features/auth/login/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   leading: SMBackButton(buttonColor: AppColors.primary),
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
            'Masuk',
            textAlign: TextAlign.center,
            style:
                AppTextStyle.heading5Bold.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Masukkan Akun Kamu',
            textAlign: TextAlign.center,
            style:
                AppTextStyle.body2Regular.copyWith(color: AppColors.neutral06),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                LoginEmailInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                LoginPasswordInputWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Obx(() => Checkbox(
                              activeColor: AppColors.primary,
                              value: controller.rememberMe.value,
                              onChanged: ((value) => controller.rememberMe
                                  .value = !controller.rememberMe.value))),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Ingat Saya?',
                          style: AppTextStyle.body3Regular,
                        )
                      ],
                    ),
                    ForgotPasswordText()
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          LoginButton(),
          const SizedBox(
            height: 32.0,
          ),
          RegisterButton(),
        ],
      )),
    );
  }
}
