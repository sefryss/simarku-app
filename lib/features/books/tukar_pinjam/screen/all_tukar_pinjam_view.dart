import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AllTukarPinjamView extends StatefulWidget {
  const AllTukarPinjamView({super.key});

  @override
  State<AllTukarPinjamView> createState() => _AllTukarPinjamViewState();
}

class _AllTukarPinjamViewState extends State<AllTukarPinjamView> {
  final RxString queryText = ''.obs;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCopyrightWarning(context);
    });
  }

  void _showCopyrightWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.neutral01,
          title: Text("Tukar Pinjam"),
          content: SingleChildScrollView(
            child: Text(
              textAlign: TextAlign.justify,
              style: AppTextStyle.body2Regular,
              "Sebelum anda melakukan Tukar Pinjam, dan jenis buku yang akan ditukar pinjam adalah buku fisik maka pastikan kalian berkomunikasi dengan yang mengajukan Tukar Pinjam terlebih dahulu untuk melakukan pertemuan atau mengatur pengiriman buku dan setelah menerima masing-masing buku baru Anda bisa menerima atau menyetujui pengajuan Tukar Pinjam.",
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style:
                    AppTextStyle.body2Medium.copyWith(color: AppColors.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          'Tukar Pinjam',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FireBaseData.getTukarPinjamBookList(),
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

                  // Filter and sort the book list based on the query text
                  List<StoryModel> filteredBookList = bookList.where((book) {
                    return book.name!
                        .toLowerCase()
                        .contains(queryText.value.toLowerCase());
                  }).toList();

                  // Sort the filtered list to ensure the order remains consistent
                  filteredBookList.sort((a, b) => a.name!.compareTo(b.name!));

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
