import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookTypeDropdown extends StatelessWidget {
  final Function(BookType)? onChanged;
  final BookType? value;
  final BookController bookController;

  const BookTypeDropdown(
    this.bookController, {
    super.key,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return getDropdown(context: context, bookController: bookController);
  }

  Widget getDropdown({
    required BuildContext context,
    required BookController bookController,
  }) {
    return Obx(
      () => DropdownButtonFormField<BookType>(
        value: bookController.bookType.value,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.neutral04,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.neutral04,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          hintText: 'Pilih Jenis Buku',
          hintStyle: AppTextStyle.paragraphRegular
              .copyWith(color: const Color(0xFF8B849B)),
        ),
        items: bookController.bookTypeList.map((BookType bookType) {
          return DropdownMenuItem<BookType>(
            value: bookType,
            child: Text(
              getBookTypeString(bookType),
              style: AppTextStyle.body2Regular,
            ),
          );
        }).toList(),
        onChanged: (BookType? newValue) {
          if (newValue != null && newValue != bookController.bookType.value) {
            bookController.bookType.value = newValue;
            onChanged?.call(newValue);
          }
        },
        validator: (value) =>
            SMValidator.validateEmptyField('Jenis Buku', value?.toString()),
      ),
    );
  }
}
