import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:intl/date_symbol_data_local.dart';

class BookReleaseDateWidget extends StatelessWidget {
  const BookReleaseDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal Rilis',
            style: AppTextStyle.body3Medium,
          ),
          const SizedBox(
            height: 8.0,
          ),
          DateTimePickerWidget(context, controller.releaseDateController)
        ],
      ),
    );
  }
}

Widget DateTimePickerWidget(
  BuildContext context,
  TextEditingController controller,
) {
  return GestureDetector(
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        controller.text = DateFormat('MMM d, yyyy', 'id_ID').format(pickedDate);
      }
    },
    child: AbsorbPointer(
      child: TextFormField(
        // validator: (value) =>
        //     SMValidator.validateEmptyField('Tanggal Rilis', value),
        controller: controller,
        style: AppTextStyle.body2Regular.copyWith(color: AppColors.black),
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
              )),
          errorBorder: InputBorder.none,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.neutral04,
                width: 1,
              )),
          filled: true,
          fillColor: const Color(0xFFFFFBFE),
          hintText: 'Tanggal Rilis',
          hintStyle: AppTextStyle.paragraphRegular
              .copyWith(color: const Color(0xFF8B849B)),
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    ),
  );
}
