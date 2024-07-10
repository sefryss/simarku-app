import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

class TnC extends StatelessWidget {
  const TnC({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Saya menyetujui ',
                  style: AppTextStyle.body3Regular,
                ),
                TextSpan(
                  text: 'Syarat dan Ketentuan',
                  style: AppTextStyle.body3Medium.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL(
                          'https://syarat-ketentuan-simarku.netlify.app/');
                    },
                ),
                TextSpan(
                  text: ' serta ',
                  style: AppTextStyle.body3Regular,
                ),
                TextSpan(
                  text: 'Kebijakan Privasi',
                  style: AppTextStyle.body3Medium.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL(
                          'https://kebijakan-privasi-simarku.netlify.app/');
                    },
                ),
                TextSpan(
                  text: ' SiMarKu',
                  style: AppTextStyle.body3Regular,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
