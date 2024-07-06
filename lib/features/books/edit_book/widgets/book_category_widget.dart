import 'package:flutter/material.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/validation/validation.dart';
import 'package:get/get.dart';

class BookCategoryWidget extends StatelessWidget {
  const BookCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());

    // Pastikan nilai awal sesuai dengan kategori yang diperbolehkan
    if (controller.category.value == Category.bebasBaca) {
      controller.category.value = Category.tukarPinjam;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pilih Kategori', style: AppTextStyle.body3Medium),
        SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<Category>(
            value: controller.category.value,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.neutral04,
                    width: 1,
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              hintText: 'Pilih Kategori',
              hintStyle: AppTextStyle.paragraphRegular
                  .copyWith(color: const Color(0xFF8B849B)),
            ),
            items: Category.values
                .where((category) =>
                    category != Category.bebasBaca) // Filter category here
                .map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(
                  getCategoryString(category),
                  style: AppTextStyle.body2Regular,
                ),
              );
            }).toList(),
            onChanged: (Category? newValue) {
              if (newValue != null && newValue != controller.category.value) {
                controller.category.value = newValue;
              }
            },
            validator: (value) =>
                SMValidator.validateEmptyField('Kategori', value?.toString()),
          ),
        ),
      ],
    );
  }
}
