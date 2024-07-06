import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookAuthorWidget extends StatelessWidget {
  const BookAuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
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
