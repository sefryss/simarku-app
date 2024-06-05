import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookPageWidget extends StatelessWidget {
  const DonationBookPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SMTextField(
        validator: (value) => SMValidator.validateEmptyField('Halaman', value),
        //   controller: controller.fullName,
        labelText: 'Halaman',
        labelColor: AppColors.neutralBlack,
        hintText: 'Masukkan Halaman',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        enabledBorderColor: AppColors.neutral04,
      ),
    );
  }
}
