import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simarku/features/books/add_book/screen/add_book_page.dart';
import 'package:simarku/features/books/edit_book/screen/edit_book_page.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class MyBook extends StatefulWidget {
  const MyBook({super.key});

  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  late Future<List<StoryModel>> _userBooks;

  @override
  void initState() {
    super.initState();
    _userBooks = _fetchUserBooks();
  }

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

  Future<void> _refreshBooks() async {
    setState(() {
      _userBooks = _fetchUserBooks();
    });
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
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RefreshIndicator(
                onRefresh: _refreshBooks,
                child: FutureBuilder<List<StoryModel>>(
                  future: _userBooks,
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
                            SizedBox(height: 24),
                            Text(
                              'Kamu belum mengupload buku apapun,\nAyo tambahkan buku kamu disini!',
                              style: AppTextStyle.body3Regular
                                  .copyWith(color: AppColors.neutral08),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            SMElevatedButton(
                              onPressed: () {
                                Get.to(() => AddBookPage());
                              },
                              labelText: 'Tambah Buku',
                              width: 170,
                            ),
                          ],
                        ),
                      );
                    }

                    final books = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.49,
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () =>
                              Get.to(() => DetailBook(book: books[index])),
                          onLongPress: () {
                            _showBookOptions(context, books[index]);
                          },
                          child: BookCard(book: books[index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FutureBuilder<List<StoryModel>>(
        future: _userBooks,
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

  void _showBookOptions(BuildContext context, StoryModel book) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Builder(
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.neutral04),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: Icon(
                            Icons.edit,
                            color: AppColors.second,
                          ),
                          title: Text('Edit'),
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => EditBookPage(book: book));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          title: Text('Hapus'),
                          onTap: () {
                            Navigator.pop(context);
                            _showDeleteConfirmationDialog(context, book);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, StoryModel book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah anda ingin menghapus buku ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: Text(
                'Tidak',
                style: TextStyle(color: AppColors.second),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
                _deleteBook(context, book);
              },
              child: Text(
                'Ya',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(BuildContext context, StoryModel book) async {
    try {
      await FirebaseFirestore.instance
          .collection('books')
          .doc(book.id)
          .delete();
      SMLoaders.successSnackBar(
          title: 'Berhasil', message: 'Buku berhasil dihapus');
      _refreshBooks(); // Refresh the book list after deletion
    } catch (e) {
      SMLoaders.errorSnackBar(
          title: 'Gagal', message: 'Gagal menghapus buku: $e');
    }
  }
}
