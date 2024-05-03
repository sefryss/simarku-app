import 'package:flutter/material.dart';
import '../../../utils/global/app_config.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RegisterPage(),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Ajukan Penukaran",
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
