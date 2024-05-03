import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';


class AuthSuccessDialog extends StatelessWidget {
  const AuthSuccessDialog({
    super.key,
    required this.onPressed,
    required this.title,
    required this.body,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String title;
  final String body;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                "assets/icons/success-dialog.svg",
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: AppTextStyle.body2SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              body,
              style: AppTextStyle.body3Regular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: SMElevatedButton(
                backgroundColor: AppColors.primary,
                onPressed: onPressed,
                labelText: buttonText,
                customTextStyle: AppTextStyle.body3Medium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
