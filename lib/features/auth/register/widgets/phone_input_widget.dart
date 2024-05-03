import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class RegisterPhoneInputWidget extends StatelessWidget {
  const RegisterPhoneInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SMTextField(
      validator: (value) => SMValidator.validatePhoneNumber(value),
      controller: controller.phoneNumber,
      labelText: 'Nomor Telepon',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Nomor Telepon',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
      onChanged: (phone) => {},
      // errorText: 'Email pengguna tidak boleh kosong',
    );
  }
}
