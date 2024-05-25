import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/utils/global/app_config.dart';

class SearchBook extends StatelessWidget {
  final RxString queryText;
  const SearchBook({
    super.key,
    required this.queryText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        queryText.value = value.toLowerCase(); // Update search query
      },
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: 'Cari Buku',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.neutral04,
          ),
        ),
      ),
    );
  }
}
