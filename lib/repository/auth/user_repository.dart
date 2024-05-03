import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/exceptions/exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  // Function to Fetch User Details by uId
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  // Update User Details
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  // Update User Details
  Future<void> updateUserField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }

  // Upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw SMFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SMFormatException();
    } on PlatformException catch (e) {
      throw SMPlatformException(e.code).message;
    } catch (e) {
      throw 'Terjadi kesalahan. Mohon coba lagi';
    }
  }
}
