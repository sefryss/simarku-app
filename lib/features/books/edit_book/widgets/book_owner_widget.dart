import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/validation/validation.dart';

class BookOwnerWidget extends StatelessWidget {
  const BookOwnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Pemilik',
          style: AppTextStyle.body3Medium,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TextFormField(
              style: AppTextStyle.body2Regular.copyWith(color: AppColors.black),
              validator: (value) =>
                  SMValidator.validateEmptyField('Pemilik', value),
              enabled: false,
              controller: controller.ownerController,
              decoration: InputDecoration(
                hintText: 'Pemilik',
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                    )),
                filled: true,
                fillColor: const Color(0xFFFFFBFE),
              ),
            )),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                await controller.showOwnerDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.neutral05),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.neutral02,
                ),
                child: Text(
                  'Pilih Pemilik',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
