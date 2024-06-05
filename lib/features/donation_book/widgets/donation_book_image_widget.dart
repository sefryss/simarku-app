import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

class DonationBookImageWidget extends StatelessWidget {
  const DonationBookImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 170,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.neutral02,
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
