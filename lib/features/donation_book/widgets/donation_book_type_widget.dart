import 'package:flutter/material.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/features/books/add_book/widgets/book_type_dropdown.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:get/get.dart';

class DonationBookTypeWidget extends StatelessWidget {
  const DonationBookTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bookController = Get.put(BookController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pilih Jenis Buku', style: AppTextStyle.body3Medium),
        SizedBox(height: 8),
        Obx(() {
          return BookTypeDropdown(
             bookController,
            value: bookController.bookType.value,
            onChanged: (value) {
              if (value != bookController.bookType.value) {
                bookController.bookType.value = value;
              }
            },
          );
        }),
        SizedBox(height: 10),
        Obx(() {
          return (bookController.bookType.value == BookType.physicalBook)
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload PDF', style: AppTextStyle.body3Medium),
                    SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      onTap: () {},
                      decoration: InputDecoration(
                        hintText: 'Tidak ada file dipilih',
                        hintStyle: AppTextStyle.paragraphRegular
                            .copyWith(color: const Color(0xFF8B849B)),
                        errorMaxLines: 2,
                        errorStyle: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red),
                        helperStyle: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.b1Yellow),
                        helperMaxLines: 2,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        disabledBorder: OutlineInputBorder(
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
                        filled: true,
                        fillColor: const Color(0xFFFFFBFE),
                      ),
                    ),
                  ],
                );
        }),
      ],
    );
  }
}
