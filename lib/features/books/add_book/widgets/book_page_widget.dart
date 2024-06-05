import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookPageWidget extends StatelessWidget {
  const BookPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return Expanded(
      child: SMTextField(
        validator: (value) => SMValidator.validateEmptyField('Halaman', value),
          controller: controller.pageController,
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
