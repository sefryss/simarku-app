import 'package:flutter/material.dart';

import '../global/app_config.dart';

class SMElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final TextStyle? customTextStyle;
  final bool isLoading;

  const SMElevatedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.backgroundColor = AppColors.primary,
    this.disableBackgroundColor = AppColors.grey,
    this.labelColor = AppColors.white,
    this.borderRadius,
    this.width,
    this.height,
    this.customTextStyle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disableBackgroundColor,
            backgroundColor: backgroundColor,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0))),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: labelColor,
                ),
              )
            : Text(
                labelText,
                textAlign: TextAlign.center,
                style: AppTextStyle.paragraphMedium.copyWith(color: labelColor),
              ),
      ),
    );
  }
}

class SMOutlineElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;
  final Color labelColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color disableBorderColor;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final TextStyle? customTextStyle;
  final bool isLoading;

  const SMOutlineElevatedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.primary,
    this.disableBorderColor = AppColors.grey,
    this.labelColor = AppColors.primary,
    this.borderRadius,
    this.width,
    this.height,
    this.customTextStyle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            side: BorderSide(
                color: isLoading ? disableBorderColor : borderColor,
                width: 1.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0))),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: labelColor,
                ),
              )
            : Text(
                labelText,
                textAlign: TextAlign.center,
                style: AppTextStyle.paragraphMedium.copyWith(color: labelColor),
              ),
      ),
    );
  }
}

class SMElevatedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final Widget icon;
  final BorderRadiusGeometry? borderRadius;

  const SMElevatedButtonWithIcon(
      {super.key,
      required this.onPressed,
      required this.labelText,
      this.backgroundColor = AppColors.primary,
      this.disableBackgroundColor = AppColors.grey,
      required this.icon,
      this.labelColor = AppColors.black,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        labelText,
        style: AppTextStyle.body2Bold.copyWith(color: labelColor),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disableBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8.0))),
    );
  }
}
