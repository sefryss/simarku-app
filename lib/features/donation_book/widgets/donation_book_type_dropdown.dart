import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/donation_book_controller.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/validation/validation.dart';

class DonationBookTypeDropdown extends StatelessWidget {
  final Function(DonationBookType)? onChanged;
  final DonationBookType? value;
  final DonationBookController donationBookController;

  const DonationBookTypeDropdown(
    this.donationBookController, {
    super.key,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return getDropdown(
        context: context, donationBookController: donationBookController);
  }

  Widget getDropdown({
    required BuildContext context,
    required DonationBookController donationBookController,
  }) {
    return Obx(
      () => DropdownButtonFormField<DonationBookType>(
        value: donationBookController.bookType.value,
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
          hintText: 'Pilih Kategori',
          hintStyle: AppTextStyle.paragraphRegular
              .copyWith(color: const Color(0xFF8B849B)),
        ),
        items: donationBookController.bookTypeList
            .map((DonationBookType donationBookType) {
          return DropdownMenuItem<DonationBookType>(
            value: donationBookType,
            child: Text(
              getDonationBookTypeString(donationBookType),
              style: AppTextStyle.body2Regular,
            ),
          );
        }).toList(),
        onChanged: (DonationBookType? newValue) {
          if (newValue != null &&
              newValue != donationBookController.bookType.value) {
            donationBookController.bookType.value = newValue;
            onChanged?.call(newValue);
          }
        },
        validator: (value) =>
            SMValidator.validateEmptyField('Kategori', value?.toString()),
      ),
    );
  }
}
