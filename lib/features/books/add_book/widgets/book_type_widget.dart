import 'package:flutter/material.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/features/books/add_book/widgets/book_type_dropdown.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:get/get.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookTypeWidget extends StatelessWidget {
  const BookTypeWidget({super.key});

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: AppTextStyle.body2Regular
                                .copyWith(color: AppColors.black),
                            controller: TextEditingController(
                                text: bookController.pdfUrl.value),
                            validator: (value) =>
                                SMValidator.validateEmptyField('PDF', value),
                            enabled: false,
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
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            bookController.openFile();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.neutral05),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.neutral02,
                            ),
                            child: Text(
                              'Pilih File',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    Obx(() {
                      return (bookController.pdfUrl.value.isNotEmpty)
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/pdf.png',
                                    height: 44,
                                    width: 32,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Text(
                                            bookController.pdfUrl.value,
                                            style: AppTextStyle.body2Regular,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          bookController.pdfSize.value,
                                          style: AppTextStyle.body3Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bookController.pdfUrl.value = '';
                                    },
                                    child: Image.asset(
                                      'assets/images/trash.png',
                                      height: 24,
                                      width: 24,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container();
                    })
                  ],
                );
        }),
      ],
    );
  }
}
