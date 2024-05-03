import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simarku/controllers/auth/signup_controller.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

import '../../../../utils/global/app_config.dart';

class RegisterAddressInputWidget extends StatelessWidget {
  const RegisterAddressInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SMTextField(
      validator: (value) =>
          SMValidator.validateEmptyField('Alamat Lengkap', value),
      controller: controller.address,
      labelText: 'Alamat Lengkap',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Alamat Lengkap',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
