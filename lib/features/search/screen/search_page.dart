import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/controllers/firbase_data/key_table.dart';
import 'package:simarku/features/dashboard/widgets/detail_book.dart';
import 'package:simarku/features/search/widgets/all_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/filter.dart';
import 'package:simarku/features/search/widgets/search_field_widget.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/book_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/routes/app_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString queryText = ''.obs;
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
              SearchBook(
                queryText: queryText,
              ),
              //   Expanded(
              //     child: StreamBuilder<QuerySnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection(KeyTable.storyList)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         }
              //         if (snapshot.hasError) {
              //           return Center(
              //             child: Text('Error: ${snapshot.error}'),
              //           );
              //         }

              //         final List<DocumentSnapshot> documents =
              //             snapshot.data!.docs;

              //         return ListView.builder(
              //           itemCount: documents.length,
              //           itemBuilder: (context, index) {
              //             final StoryModel storyModel =
              //                 StoryModel.fromFirestore(documents[index]);

              //             bool shouldShowCell = true;

              //             if (queryText.value.isNotEmpty &&
              //                 !storyModel.name!
              //                     .toLowerCase()
              //                     .contains(queryText.value)) {
              //               shouldShowCell = false;
              //             }

              //             // if (shouldShowCell) {
              //             //   return YourCustomCellWidget(storyModel: storyModel);
              //             // } else {
              //             //   return SizedBox(); // If the cell should not be shown, return an empty SizedBox
              //             // }
              //           },
              //         );
              //       },
              //     ),
              //   ),
              SizedBox(
                height: 16,
              ),
              BookFilter(),
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
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseData.getPopularList(),
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

                    List<StoryModel> filteredBookList = bookList.toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredBookList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
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
              ),
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
                  InkWell(
                    onTap: () => Get.to(
                      () => PhysicalBookView(),
                    ),
                    child: Text(
                      'Lebih Banyak',
                      style: AppTextStyle.body3Medium
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseData.getPhysicalBooks(limit: 4),
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

                    List<StoryModel> filteredBookList = bookList.toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredBookList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
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
              ),
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
                  InkWell(
                    onTap: () => Get.to(
                      () => EBookView(),
                    ),
                    child: Text(
                      'Lebih Banyak',
                      style: AppTextStyle.body3Medium
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseData.getEBooks(limit: 4),
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

                    List<StoryModel> filteredBookList = bookList.toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredBookList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
