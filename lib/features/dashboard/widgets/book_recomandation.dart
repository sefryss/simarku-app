import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
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
            separatorBuilder: (context, index) => const SizedBox(width: 0),
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
          );
        },
      ),
    );
  }
}
