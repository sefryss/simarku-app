import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/models.dart';

class BookRecommendation extends StatelessWidget {
  const BookRecommendation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
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

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: bookList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 0),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.to(
                  () => DetailBook(book: bookList[index]),
                ),
                child: BookCard(
                  book: bookList[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
