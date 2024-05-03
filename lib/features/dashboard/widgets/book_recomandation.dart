import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/utils/global/app_colors.dart';
import 'package:simarku/utils/global/app_text_style.dart';
import 'package:simarku/models/models.dart';

class BookRecommendation extends StatelessWidget {
  const BookRecommendation();

  @override
  Widget build(BuildContext context) {
    List<Book> filteredBookList = List<Book>.from(bookList).sublist(0, 6);
    return Container(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filteredBookList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(
              () => DetailBook(book: filteredBookList[index]),
            ),
            child: BookCard(
              book: filteredBookList[index],
            ),
          );
        },
      ),
    );
  }
}

//Book Card
class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      // height: 160,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              book.thumbnail,
              height: 160,
              width: 110,
            ),
          ),
          const SizedBox(height: 8),
          // Modified text widgets for title and author

          Text(
            book.title,
            style: AppTextStyle.body3SemiBold,
            maxLines: 2, // Max 2 lines for title
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

          Text(
            book.author,
            style: AppTextStyle.body4Regular.copyWith(color: AppColors.primary),
            maxLines: 1, // Max 1 line for author
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

