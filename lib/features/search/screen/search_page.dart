import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/search/widgets/all_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/filter.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/routes/app_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Jelajah',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBook(),
              SizedBox(
                height: 16,
              ),
              EventFilter(),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paling Populer',
                    style: AppTextStyle.body2Medium,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed(Routes.article);
                  //   },
                  //   child: Text(
                  //     'Lebih Banyak',
                  //     style: AppTextStyle.body3Medium
                  //         .copyWith(color: AppColors.primary),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              BookRecommendation(),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buku Fisik',
                    style: AppTextStyle.body2Medium,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed(Routes.article);
                  //   },
                  //   child: Text(
                  //     'Lebih Banyak',
                  //     style: AppTextStyle.body3Medium
                  //         .copyWith(color: AppColors.primary),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              BookRecommendation(),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'E-Book',
                    style: AppTextStyle.body2Medium,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed(Routes.article);
                  //   },
                  //   child: Text(
                  //     'Lebih Banyak',
                  //     style: AppTextStyle.body3Medium
                  //         .copyWith(color: AppColors.primary),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              BookRecommendation(),
            ],
          ),
        ),
      ),
    );
  }
}
