import 'package:flutter/material.dart';

import '../global/app_config.dart';

class SMTextField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? focusedBorder;
  final Color? labelColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? enabledBorderColor;
  final bool readOnly;
  final Color? borderColor;
  final bool? enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  // this use in apply job
  final bool isOptional;
  final int? maxLines;

  const SMTextField({
    this.validator,
    super.key,
    this.initialValue,
    this.borderColor,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.helperText,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.focusedBorder,
    this.labelColor = AppColors.neutral02,
    this.textStyle,
    this.enabledBorderColor,
    this.hintStyle,
    this.readOnly = false,
    this.enabled,
    this.isOptional = false,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: AppTextStyle.body3Medium.copyWith(color: labelColor),
            ),
            if (isOptional)
              Text(
                "Optional",
                style: AppTextStyle.body4Regular
                    .copyWith(color: AppColors.primary),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          validator: validator,
          cursorColor: AppColors.primary,
          controller: controller,
          enabled: enabled,
          initialValue: initialValue,
          obscuringCharacter: '●',
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onChanged: onChanged,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: AppTextStyle.paragraphRegular
                .copyWith(color: const Color(0xFF8B849B)),
            errorText: errorText,
            errorMaxLines: 2,
            errorStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: AppColors.red),
            helperText: helperText,
            helperStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: AppColors.b1Yellow),
            helperMaxLines: 2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: enabledBorderColor ?? const Color(0xFF8BB4FF),
                  width: 1,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1,
                )),
            filled: true,
            fillColor: const Color(0xFFFFFBFE),
          ),
        )
      ],
    );
  }
}
