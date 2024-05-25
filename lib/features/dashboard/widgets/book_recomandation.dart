import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/utils/global/app_colors.dart';
import 'package:simarku/utils/global/app_text_style.dart';
import 'package:simarku/models/models.dart';

class BookRecommendation extends StatelessWidget {
  const BookRecommendation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: StreamBuilder<QuerySnapshot>(
        stream: FireBaseData.getFeaturedList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<StoryModel> bookList = snapshot.data!.docs.map((doc) {
            return StoryModel.fromFirestore(doc);
          }).toList();

          List<StoryModel> filteredBookList = bookList.take(6).toList();

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filteredBookList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()
                => Get.to(
                  () => DetailBook(book: filteredBookList[index]),
                ),
                child: BookCard(
                  book: filteredBookList[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//Book Card
class BookCard extends StatelessWidget {
  final StoryModel book;
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
