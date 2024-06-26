import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AllBebasBacaView extends StatefulWidget {
  const AllBebasBacaView({super.key});

  @override
  State<AllBebasBacaView> createState() => _AllBebasBacaViewState();
}

class _AllBebasBacaViewState extends State<AllBebasBacaView> {
  final RxString queryText = ''.obs;
  final TextEditingController textEditingController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 16.0),
              child: searchField(context, 'Cari Buku', textEditingController,
                  onChanged: (value) {
                setState(() {
                  queryText.value = value;
                });
              }),
            ),
            SizedBox(height: 16),
            Expanded(
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
                  if (queryText.value.isNotEmpty) {
                    filteredBookList = bookList
                        .where((book) => book.name!
                            .toLowerCase()
                            .contains(queryText.value.toLowerCase()))
                        .toList();
                  }

                  if (filteredBookList.isEmpty) {
                    return Center(child: Text('Tidak ada buku'));
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: filteredBookList.length,
                    itemBuilder: (context, index) {
                      StoryModel storyModel = filteredBookList[index];
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
    );
  }
}
