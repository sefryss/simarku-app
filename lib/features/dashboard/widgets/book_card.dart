import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

//Book Card
class BookCard extends StatelessWidget {
  final StoryModel book;
  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 110,
        // height: 200,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.image ?? '',
                height: 160,
                width: 110,
              ),
            ),
            const SizedBox(height: 8),
            // Modified text widgets for title and author

            Text(
              book.name ?? '',
              style: AppTextStyle.body3SemiBold,
              maxLines: 2, // Max 2 lines for title
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),

            Text(
              book.author ?? '',
              style:
                  AppTextStyle.body4Regular.copyWith(color: AppColors.primary),
              maxLines: 1, // Max 1 line for author
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
