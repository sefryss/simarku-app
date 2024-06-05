import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/controllers/books/detail_book_controller.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/home/home_page.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class FavouriteBook extends StatelessWidget {
  const FavouriteBook({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<NavigationController>();
    // Inisialisasi controller
    final DetailBookScreenController controller =
        Get.put(DetailBookScreenController());

    // Panggil fungsi untuk mendapatkan daftar bookmark saat inisialisasi
    Future.delayed(Duration.zero, () async {
      controller.getBookMarkList();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Buku Favorit',
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
          child: Obx(() {
            if (controller.bookMarkList.isEmpty) {
              return Center(
                child: Text(
                  'Tidak ada buku favorit',
                  style: AppTextStyle.body1Regular,
                ),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('Tidak ada data.'));
                }

                var favouriteBooks = snapshot.data!.docs.where((doc) {
                  return controller.bookMarkList.contains(doc.id);
                }).toList();

                if (favouriteBooks.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/empty.svg',
                            height: 300,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Tidak ada buku favorit',
                            style: AppTextStyle.body1Regular,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: favouriteBooks.length,
                  itemBuilder: (context, index) {
                    var book = StoryModel.fromFirestore(favouriteBooks[index]);
                    return InkWell(
                      onTap: () => Get.to(
                        () => DetailBook(book: book),
                      ),
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
