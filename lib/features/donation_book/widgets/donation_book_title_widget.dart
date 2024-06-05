import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookTitleWidget extends StatelessWidget {
  const DonationBookTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SMTextField(
      validator: (value) => SMValidator.validateEmptyField('Judul Buku', value),
      //   controller: controller.fullName,
      labelText: 'Judul Buku',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Judul Buku',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
