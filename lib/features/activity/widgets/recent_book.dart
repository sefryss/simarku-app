import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/detail_book_controller.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class RecentBook extends StatefulWidget {
  const RecentBook({Key? key});

  @override
  State<RecentBook> createState() => _RecentBookState();
}

class _RecentBookState extends State<RecentBook> {
  final RecentController controller = Get.put(RecentController());

  @override
  void initState() {
    super.initState();
    controller.getRecentDataList(); // Ambil data buku terakhir yang dibaca
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
            16.0,
            0,
            16.0,
          ),
          child: Obx(() {
            final List<String> recentList = controller.recentList.toList();

            if (recentList.isEmpty) {
              return Center(child: Text('Tidak ada buku'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.5,
              ),
              itemCount: recentList.length,
              itemBuilder: (context, index) {
                String bookId = recentList[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FireBaseData.getBookById(bookId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      return Container(); // Ganti dengan pesan error jika perlu
                    }

                    StoryModel book = StoryModel.fromFirestore(snapshot.data!);

                    return InkWell(
                      onTap: () => Get.to(() => DetailBook(book: book)),
                      child: BookCard(
                        book: book,
                      ),
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
