import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookDescWidget extends StatelessWidget {
  const DonationBookDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SMTextField(
      validator: (value) => SMValidator.validateEmptyField('Sinposis', value),
      //   controller: controller.fullName,
      labelText: 'Sinposis',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Sinposis',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
      maxLines: 14,
    );
  }
}
