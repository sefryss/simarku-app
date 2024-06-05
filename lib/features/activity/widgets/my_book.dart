import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simarku/features/books/add_book/screen/add_book_page.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class MyBook extends StatelessWidget {
  const MyBook({super.key});

  Future<List<StoryModel>> _fetchUserBooks() async {
    // Get the current user
    final user = AuthRepository.instance.authUser;
    if (user == null) {
      throw 'User tidak login';
    }

    // Fetch books from Firestore where ownerId contains the current user's ID
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('owner_id', arrayContains: user.uid)
        .get();

    // Map the documents to StoryModel instances
    return snapshot.docs.map((doc) => StoryModel.fromFirestore(doc)).toList();
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
          'Buku Saya',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            0,
            16.0,
            16.0,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FutureBuilder<List<StoryModel>>(
                future: _fetchUserBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
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
                            'Kamu belum mengupload buku apapun,\nAyo tambahkan buku kamu disini!',
                            style: AppTextStyle.body2Regular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          SMElevatedButton(
                            onPressed: () {
                              Get.to(() => AddBookPage());
                            },
                            labelText: 'Tambah Buku',
                            width: 185,
                          ),
                        ],
                      ),
                    );
                  }

                  final books = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 220,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.5,
                            ),
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.to(
                                  () => DetailBook(book: books[index]),
                                ),
                                child: BookCard(
                                  book: books[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FutureBuilder<List<StoryModel>>(
        future: _fetchUserBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                Get.to(() => AddBookPage());
              },
              child: Icon(
                Icons.add,
                color: AppColors.neutral02,
              ),
            );
          } else {
            return Container(); // Return an empty container if no data
          }
        },
      ),
    );
  }
}
