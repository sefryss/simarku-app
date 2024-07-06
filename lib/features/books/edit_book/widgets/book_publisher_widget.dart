import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookPublisherWidget extends StatelessWidget {
  const BookPublisherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return Expanded(
      child: SMTextField(
        validator: (value) =>
            SMValidator.validateEmptyField('Penerbit Buku', value),
          controller: controller.publisherController,
        labelText: 'Penerbit Buku',
        labelColor: AppColors.neutralBlack,
        hintText: 'Masukkan Penerbit Buku',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        enabledBorderColor: AppColors.neutral04,
      ),
    );
  }
}
