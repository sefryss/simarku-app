import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simarku/utils/global/app_config.dart';

class DonationBookReleaseDateWidget extends StatelessWidget {
  const DonationBookReleaseDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          DateTimePickerWidget(
            context,
            'Tanggal Rilis',
          )
        ],
      ),
    );
  }
}

Widget DateTimePickerWidget(
  BuildContext context,
  String hintText,
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
        DateFormat('MMMM d, yyyy', 'id_ID').format(pickedDate);
      }
    },
    child: AbsorbPointer(
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: InputBorder.none,
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
          errorBorder: InputBorder.none,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.neutral04,
                width: 1,
              )),
          filled: true,
          fillColor: const Color(0xFFFFFBFE),
          hintText: hintText,
          hintStyle: AppTextStyle.paragraphRegular
              .copyWith(color: const Color(0xFF8B849B)),
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    ),
  );
}
