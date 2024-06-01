import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AllTukarMilikView extends StatefulWidget {
  const AllTukarMilikView({super.key});

  @override
  State<AllTukarMilikView> createState() => _AllTukarMilikViewState();
}

class _AllTukarMilikViewState extends State<AllTukarMilikView> {
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
          'Tukar Milik',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            0,
            16.0,
          ),
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
              Container(
                height: 220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseData.getTukarMilikBookList(),
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
                      bookList = bookList
                          .where((book) => book.name!
                              .toLowerCase()
                              .contains(queryText.value.toLowerCase()))
                          .toList();
                    }

                    if (bookList.isEmpty) {
                      return Center(child: Text('Tidak ada buku'));
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: filteredBookList.length,
                      itemBuilder: (context, index) {
                        StoryModel storyModel = filteredBookList[
                            index]; // Menggunakan filteredBookList
                        bool cell = true;

                        if (queryText.value.isNotEmpty &&
                            !storyModel.name!
                                .toLowerCase()
                                .contains(queryText.value.toLowerCase())) {
                          cell = false;
                        }

                        return cell
                            ? InkWell(
                                onTap: () => Get.to(
                                  () =>
                                      DetailBook(book: filteredBookList[index]),
                                ),
                                child: BookCard(
                                  book: filteredBookList[index],
                                ),
                              )
                            : Container(); // If cell is false, return an empty container
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
