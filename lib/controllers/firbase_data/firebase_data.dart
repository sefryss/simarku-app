import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/controllers/firbase_data/key_table.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:flutter/material.dart';
import 'package:simarku/utils/constantWidget.dart';

class FireBaseData {
  static Future<DocumentSnapshot<Map<String, dynamic>>> getBookById(
      String bookId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookSnapshot =
          await FirebaseFirestore.instance
              .collection('books') // Ganti dengan nama koleksi Anda
              .doc(bookId)
              .get();
      return bookSnapshot;
    } catch (e) {
      print('Error getting book by id: $e');
      throw e; // Atau lakukan penanganan kesalahan lainnya sesuai kebutuhan aplikasi Anda
    }
  }
//   static insertData(
//       {required var map,
//       required String tableName,
//       required Function function,
//       required BuildContext context}) async {
//     FirebaseFirestore.instance.collection(tableName).add(map).then((value) {
//       showCustomToast(
//         message: "Add Successfully...",
//         title: '',
//       );
//       function();
//     });
//   }

  static Future<int> getLastIndexFromTable(String table) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(table)
        .orderBy(KeyTable.index, descending: true)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.length > 0) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.length > 0) {
          StoryModel categoryModel = StoryModel.fromFirestore(list1[0]);
          return (categoryModel.index! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static updateData(
      {required var map,
      required String tableName,
      required String doc,
      required Function function,
      bool? isToast,
      required BuildContext context}) {
    print("tableName------${tableName}");

    FirebaseFirestore.instance
        .collection(tableName)
        .doc(doc)
        .update(map)
        .then((value) {
      if (isToast == null) {
        showCustomToast(
          message: "Update Successfully...",
          title: 'Success',
        );
      }
      function();
    });
  }

  static Future<int> getLastIndexFromGenreTable() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.genreList)
        .orderBy(KeyTable.index, descending: true)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.length > 0) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.length > 0) {
          Genre genreModel = Genre.fromFirestore(list1[0]);
          return (genreModel.index! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static getString(List snap) {
    return snap.toString().replaceAll("[", "").replaceAll("]", "");
  }

  static addStoryViews(StoryModel storyModel, BuildContext context) async {
    updateData(
        map: {KeyTable.views: (storyModel.views! + 1)},
        tableName: KeyTable.storyList,
        doc: storyModel.id!,
        context: context,
        function: () {});
  }

  static getGenreById({required List id}) {
    return FirebaseFirestore.instance
        .collection(KeyTable.genreList)
        .snapshots();
  }

  static String getGenreName(
      {required List genre, required List<DocumentSnapshot> list}) {
    List genreList = genre;
    List<String> genresName = [];

    String name = "";

    for (int i = 0; i < list.length; i++) {
      if (genreList.contains(list[i].id)) {
        genresName.add(Genre.fromFirestore(list[i]).genre!);
      }
    }

    name = getString(genresName);

    return name;
  }

  static getOwnerById({required List id}) {
    return FirebaseFirestore.instance
        .collection(KeyTable.ownerList)
        .snapshots();
  }

  static String getOwnerName(
      {required List owner, required List<DocumentSnapshot> list}) {
    List ownerList = owner;
    List<String> ownersName = [];

    String name = "";

    for (int i = 0; i < list.length; i++) {
      if (ownerList.contains(list[i].id)) {
        ownersName.add(UserModel.fromFirestore(list[i]).fullName);
      }
    }

    name = getString(ownersName);

    return name;
  }

  static getBookListById(String id) async {
    List<StoryModel> storyList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.refId, isEqualTo: id)
        .orderBy(KeyTable.index, descending: true)
        .get();
    if (querySnapshot.size > 0) {
      List<DocumentSnapshot> list = querySnapshot.docs;

      for (int i = 0; i < list.length; i++) {
        if (list.isNotEmpty) {
          storyList.add(StoryModel.fromFirestore(list[i]));
        }
      }
    }

    print("storyList------11111---${storyList.length}");

    return storyList;
  }

  static getBebasBacaBookList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Bebas Baca')
          .limit(limit)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Bebas Baca')
          .snapshots();
    }
  }

  static getTukarPinjamBookList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Tukar Pinjam')
          .limit(limit)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Tukar Pinjam')
          .snapshots();
    }
  }

  static getTukarMilikBookList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Tukar Milik')
          .limit(limit)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.category, isEqualTo: 'Tukar Milik')
          .snapshots();
    }
  }

  static getBookList() {
    return FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.isActive, isEqualTo: true)
        .orderBy(KeyTable.index)
        .snapshots();
  }

  static getDonationBookList() {
    return FirebaseFirestore.instance
        .collection(KeyTable.donationBook)
        .where(KeyTable.isActive, isEqualTo: true)
        .orderBy(KeyTable.index)
        .snapshots();
  }

  static getFeaturedList() {
    return FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.isActive, isEqualTo: true)
        .where(KeyTable.isFeatured, isEqualTo: true)
        .orderBy(
          KeyTable.index,
          descending: true,
        )
        .snapshots();
  }

  // Di Firebase data, ubah filter genre untuk menangani kasus ketika genre filter kosong
  static getPopularList({int limit = 0, Map<String, dynamic>? selectedItems}) {
    Query query = FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.isActive, isEqualTo: true)
        .where(KeyTable.isPopular, isEqualTo: true);

    if (selectedItems != null && selectedItems.isNotEmpty) {
      selectedItems.forEach((key, value) {
        if (key != 'book_type') {
          // Ubah kondisi untuk filter 'genre_id'
          if (key == 'genre_id' && value != null) {
            // Tambahkan pemeriksaan untuk nilai null
            if (value is List) {
              if (value.isNotEmpty) {
                // Tambahkan pemeriksaan untuk daftar tidak kosong
                query = query.where(key, arrayContainsAny: value);
              }
            }
          } else {
            query = query.where(key, isEqualTo: value);
          }
        }
      });

      if (selectedItems.containsKey('book_type')) {
        query = query.where('book_type', isEqualTo: selectedItems['book_type']);
      }
    }

    if (limit != 0) {
      query = query.limit(limit);
    }

    return query.orderBy(KeyTable.index, descending: true).snapshots();
  }

  static getPhysicalBooks(
      {int limit = 0, Map<String, dynamic>? selectedItems}) {
    Query query = FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.isActive, isEqualTo: true)
        .where(KeyTable.bookType, isEqualTo: 'Buku Fisik');

    if (selectedItems != null && selectedItems.isNotEmpty) {
      selectedItems.forEach((key, value) {
        if (key != 'book_type') {
          // Ubah kondisi untuk filter 'genre_id'
          if (key == 'genre_id' && value != null) {
            // Tambahkan pemeriksaan untuk nilai null
            if (value is List) {
              if (value.isNotEmpty) {
                // Tambahkan pemeriksaan untuk daftar tidak kosong
                query = query.where(key, arrayContainsAny: value);
              }
            }
          } else {
            query = query.where(key, isEqualTo: value);
          }
        }
      });
    }

    if (limit != 0) {
      query = query.limit(limit);
    }
    return query.orderBy(KeyTable.index, descending: true).snapshots();
  }

  static getEBooks({int limit = 0, Map<String, dynamic>? selectedItems}) {
    Query query = FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .where(KeyTable.isActive, isEqualTo: true)
        .where(KeyTable.bookType, isEqualTo: 'E-Book');

    if (selectedItems != null && selectedItems.isNotEmpty) {
      selectedItems.forEach((key, value) {
        if (key != 'book_type') {
          // Ubah kondisi untuk filter 'genre_id'
          if (key == 'genre_id' && value != null) {
            // Tambahkan pemeriksaan untuk nilai null
            if (value is List) {
              if (value.isNotEmpty) {
                // Tambahkan pemeriksaan untuk daftar tidak kosong
                query = query.where(key, arrayContainsAny: value);
              }
            }
          } else {
            query = query.where(key, isEqualTo: value);
          }
        }
      });
    }

    if (limit != 0) {
      query = query.limit(limit);
    }

    return query.orderBy(KeyTable.index, descending: true).snapshots();
  }

  static getSekilasInfoList({
    int limit = 0,
  }) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.sekilasInfo)
          .limit(limit)
          .where(KeyTable.isActive, isEqualTo: true)
          .orderBy(KeyTable.index)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection(KeyTable.sekilasInfo)
        .where(KeyTable.isActive, isEqualTo: true)
        .orderBy(KeyTable.index)
        .snapshots();
  }

  static getKegiatanLiterasiList({
    int limit = 0,
  }) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.kegiatanLiterasi)
          .limit(limit)
          .where(KeyTable.isActive, isEqualTo: true)
          .orderBy(KeyTable.index)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection(KeyTable.kegiatanLiterasi)
        .where(KeyTable.isActive, isEqualTo: true)
        .orderBy(KeyTable.index)
        .snapshots();
  }
}
