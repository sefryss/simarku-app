import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

class SearchArticle extends StatelessWidget {
  const SearchArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Cari Artikel',
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
      ),
    );
  }
}
