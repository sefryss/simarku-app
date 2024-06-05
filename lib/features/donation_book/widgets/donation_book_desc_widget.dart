import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/donation_book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookDescWidget extends StatelessWidget {
  const DonationBookDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationBookController());
    return SMTextField(
      validator: (value) => SMValidator.validateEmptyField('Sinposis', value),
      controller: controller.descController,
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
