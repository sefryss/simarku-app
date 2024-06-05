import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/donation_book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookAuthorWidget extends StatelessWidget {
  const DonationBookAuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationBookController());
    return Expanded(
      child: SMTextField(
        validator: (value) =>
            SMValidator.validateEmptyField('Penulis Buku', value),
        controller: controller.authorController,
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
