import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';

class SubmitBookButton extends StatelessWidget {
    final String bookId;
  const SubmitBookButton({
    required this.bookId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          controller.editBook(bookId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Ubah buku',
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
