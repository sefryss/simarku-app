import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/controllers/firbase_data/key_table.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:flutter/material.dart';

class FireBaseData {
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
        // showCustomToast(
        //   message: "Update Successfully...",
        //   title: 'Success',
        //   context: context,
        // );
      }
      function();
    });
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

  static getPopularList({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.isPopular, isEqualTo: true)
          .limit(limit)
          .orderBy(KeyTable.index, descending: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.isPopular, isEqualTo: true)
          .orderBy(KeyTable.index, descending: true)
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

  static getPhysicalBooks({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.bookType, isEqualTo: 'Buku Fisik')
          .limit(limit)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.bookType,
              isEqualTo:
                  'Buku Fisik') // Filter berdasarkan kategori 'Buku Fisik'
          .snapshots();
    }
  }

  static getEBooks({int limit = 0}) {
    if (limit != 0) {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.isActive, isEqualTo: true)
          .where(KeyTable.bookType, isEqualTo: 'E-Book')
          .limit(limit)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(KeyTable.storyList)
          .where(KeyTable.bookType,
              isEqualTo: 'E-Book') // Filter berdasarkan kategori 'E-Book'
          .snapshots();
    }
  }
}
