import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

Widget searchField(
  BuildContext context,
  String hintText,
  TextEditingController textEditingController, {
  bool? isEnabled,
  var inputType,
  var inputFormatters,
  ValueChanged<String>? onChanged,
}) {
  return TextFormField(
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: onChanged,
    cursorColor: AppColors.primary,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      prefixIcon: const Icon(Icons.search),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.primary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.neutral04,
        ),
      ),
    ),
  );
}
