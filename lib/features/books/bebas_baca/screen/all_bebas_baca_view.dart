import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AllBebasBacaView extends StatelessWidget {
  const AllBebasBacaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Bebas Baca',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          16.0,
          24.0,
          16.0,
          16.0,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FireBaseData.getBebasBacaBookList(),
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

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.5,
              ),
              itemCount: filteredBookList.length,
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
    );
  }
}
