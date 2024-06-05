import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

class DonationSubmitBookButton extends StatelessWidget {
  final VoidCallback? onTap;
  const DonationSubmitBookButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Donasi buku',
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
