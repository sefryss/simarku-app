import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookDescWidget extends StatelessWidget {
  const BookDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return SMTextField(
      validator: (value) => SMValidator.validateEmptyField('Sinopsis', value),
      controller: controller.descController,
      labelText: 'Sinopsis',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Sinopsis',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
      maxLines: 14,
    );
  }
}
