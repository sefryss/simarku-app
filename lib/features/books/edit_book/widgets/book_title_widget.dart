import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookTitleWidget extends StatelessWidget {
  const BookTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return SMTextField(
      validator: (value) => SMValidator.validateEmptyField('Judul Buku', value),
      controller: controller.nameController,
      labelText: 'Judul Buku',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Judul Buku',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
    );
  }
}
