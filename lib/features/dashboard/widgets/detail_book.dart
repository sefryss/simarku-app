import 'package:flutter/material.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/shared_widgets/sm_back_button.dart';

class DetailBook extends StatelessWidget {
  final Book book;
  const DetailBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Detail Buku',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.primary),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 50),
                    child: Center(
                      child: Container(
                        height: 267,
                        width: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(book.thumbnail),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 24,
                    bottom: 0,
                    start: 16,
                    end: 16,
                  ),
                  margin: EdgeInsets.only(top: 312),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: AppTextStyle.heading5SemiBold,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  book.author,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.body2Regular
                                      .copyWith(color: AppColors.neutral06),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Genre: ${book.genre}',
                        style: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.neutral08),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Penerbit: ${book.publisher}',
                        style: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.neutral08),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Sinopsis",
                        style: AppTextStyle.body1SemiBold,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        book.synopsis,
                        style: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.neutral08),
                      ),
                      // const SizedBox(height: 40),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              height: 68,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.neutral01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Rilis',
                        style: AppTextStyle.body3Regular,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        book.releaseDate,
                        style: AppTextStyle.body3Medium,
                      ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.neutral08,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Pemilik',
                          style: AppTextStyle.body3Regular,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          book.owner,
                          style: AppTextStyle.body3Medium
                              .copyWith(color: AppColors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.neutral08,
                  ),
                  Column(
                    children: [
                      Text(
                        'Halaman',
                        style: AppTextStyle.body3Regular,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        book.page,
                        style: AppTextStyle.body3Medium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const ApplyButton()
          ],
        ),
      ),
    );
  }
}
