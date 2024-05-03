import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simarku/utils/global/app_config.dart';

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const ProfileMenuWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          icon,
          color: AppColors.primary,
          width: 24,
        ),
        // Container(
        //   height: 40,
        //   width: 40,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(100),
        //       color: AppColors.neutral02),
        // ),
        title: Text(
          title,
          style: AppTextStyle.body3Medium,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: AppColors.neutral04, // Adjust color as needed
            width: 1.0, // Adjust border width as needed
          ),
        ),
      ),
    );
  }
}
