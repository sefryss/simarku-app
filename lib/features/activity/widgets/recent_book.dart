import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/detail_book_controller.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class RecentBook extends StatefulWidget {
  const RecentBook({Key? key});

  @override
  State<RecentBook> createState() => _RecentBookState();
}

class _RecentBookState extends State<RecentBook> {
  RecentController controller = Get.put(RecentController());

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      controller.getRecentDataList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Baru Saja Dibaca',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            16.0,
            24.0,
            0,
            16.0,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FireBaseData.getBookList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              List<DocumentSnapshot> list = snapshot.data!.docs;

              return GetBuilder<QuickReadController>(
                  init: QuickReadController(),
                  builder: (favController) {
                    favController.checkDataExist(list, controller.recentList);

                    if (favController.filteredRecentList.isNotEmpty) {
                      return Obx(() => GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.5,
                            ),
                            itemCount: favController.filteredRecentList.length,
                            itemBuilder: (context, index) {
                              StoryModel books = StoryModel.fromFirestore(
                                  favController.filteredRecentList[index]);
                              return InkWell(
                                onTap: () => Get.to(
                                  () => DetailBook(book: books),
                                ),
                                child: BookCard(
                                  book: books,
                                ),
                              );
                            },
                          ));
                    } else {
                      return Center(
                        child: Text('Tidak ada buku'),
                      );
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}
