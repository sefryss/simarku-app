import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';

class EBookWidget extends StatelessWidget {
  final RxString queryText;
  final Map<String, dynamic> selectedItems;
  const EBookWidget({
    super.key,
    required this.queryText,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'E-Book',
              style: AppTextStyle.body2Medium,
            ),
            InkWell(
              onTap: () => Get.to(() => EBookView()),
              child: Text(
                'Lihat Semua',
                style:
                    AppTextStyle.body3Medium.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          height: 230,
          child: StreamBuilder<QuerySnapshot>(
            stream: FireBaseData.getEBooks(
              limit: 6,
              selectedItems: selectedItems,
              // searchQuery: queryText.value,
            ),
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

              if (queryText.value.isNotEmpty) {
                bookList = bookList
                    .where((book) => book.name!
                        .toLowerCase()
                        .contains(queryText.value.toLowerCase()))
                    .toList();
              }

              if (bookList.isEmpty) {
                return Center(child: Text('Tidak ada buku'));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bookList.length,
                separatorBuilder: (context, index) => const SizedBox(width: 0),
                itemBuilder: (context, index) {
                  StoryModel storyModel = bookList[index];
                  bool cell = true;

                  if (queryText.value.isNotEmpty &&
                      !storyModel.name!
                          .toLowerCase()
                          .contains(queryText.value)) {
                    cell = false;
                  }

                  return cell
                      ? InkWell(
                          onTap: () =>
                              Get.to(() => DetailBook(book: storyModel)),
                          child: BookCard(
                            book: storyModel,
                          ),
                        )
                      : Container(); // If cell is false, return an empty container
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
