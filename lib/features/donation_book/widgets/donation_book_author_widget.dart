import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookAuthorWidget extends StatelessWidget {
  const DonationBookAuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SMTextField(
        validator: (value) =>
            SMValidator.validateEmptyField('Penulis Buku', value),
        //   controller: controller.fullName,
        labelText: 'Penulis Buku',
        labelColor: AppColors.neutralBlack,
        hintText: 'Masukkan Penulis Buku',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enabledBorderColor: AppColors.neutral04,
      ),
    );
  }
}
