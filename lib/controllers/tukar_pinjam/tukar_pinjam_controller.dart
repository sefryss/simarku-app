import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:simarku/controllers/chat/notification_access_token.dart';
import 'package:simarku/main.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/constantWidget.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class TukarPinjamController extends GetxController {
  TextEditingController ownerController = TextEditingController();
  RxString selectedBookId = ''.obs;
  RxString selectedBookName = ''.obs;

  Future<UserModel> fetchRequestedUser(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (!userDoc.exists) {
      throw 'Requested user not found in Firestore';
    }
    return UserModel.fromFirestore(userDoc);
  }

  Future<StoryModel> fetchBook(String bookId) async {
    try {
      DocumentSnapshot bookDoc = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();
      if (!bookDoc.exists) {
        throw 'Requested book not found in Firestore';
      }
      return StoryModel.fromFirestore(bookDoc);
    } catch (e) {
      print('Error fetching book: $e');
      rethrow;
    }
  }

  Future<void> sendTukarPinjamRequest(UserModel receiver, String senderBookId,
      String receiverBookId, String loanDuration) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User tidak login';
      }

      final exchangeRequest = TukarPinjamModel(
        loanEndTime: Timestamp.now(),
        id: '', // Auto-generated by Firestore
        senderId: user.uid,
        receiverId: receiver.id,
        senderBookId: senderBookId,
        receiverBookId: receiverBookId,
        status: 'Pending',
        loanDuration: loanDuration,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('TukarPinjam')
          .add(exchangeRequest.toJson());

      UserModel sender = await fetchRequestedUser(user.uid);

      print('Fetching sender book with ID: $senderBookId');
      StoryModel senderBook = await fetchBook(senderBookId);

      print('Fetching receiver book with ID: $receiverBookId');
      StoryModel receiverBook = await fetchBook(receiverBookId);

      String msg =
          '${sender.fullName} mengajukan Tukar Pinjam buku ${senderBook.name} dengan ${receiverBook.name}.';
      await sendPushNotification(receiver, msg);
    } catch (e) {
      print('Error sending tukar pinjam request: $e');
    }
  }

  Future<void> acceptTukarPinjamRequest(TukarPinjamModel request) async {
    try {
      // Calculate loan end time based on loan duration
      Duration loanDuration;
      switch (request.loanDuration) {
        case '1 Minggu':
          loanDuration = Duration(days: 7);
          break;
        case '2 Minggu':
          loanDuration = Duration(days: 14);
          break;
        case '3 Minggu':
          loanDuration = Duration(days: 21);
          break;
        case '1 Bulan':
          loanDuration = Duration(days: 30);
          break;
        default:
          loanDuration = Duration(days: 0);
      }

      print('Calculated loanDuration: $loanDuration');

      // Calculate loan end time from current date
      DateTime endDateTime = DateTime.now().add(loanDuration);
      Timestamp loanEndTime = Timestamp.fromDate(endDateTime);

      print('Calculated loanEndTime: $endDateTime');

      // Update the status of the request
      await FirebaseFirestore.instance
          .collection('TukarPinjam')
          .doc(request.id)
          .update({
        'status': 'Diterima',
        'loan_end_time': loanEndTime,
      });

      // Update the book ownership and loan end time only if the category is tukarPinjam
      final bookDocSender = FirebaseFirestore.instance
          .collection('books')
          .doc(request.senderBookId);
      final bookDocReceiver = FirebaseFirestore.instance
          .collection('books')
          .doc(request.receiverBookId);

      final bookSender = await bookDocSender.get();
      final bookReceiver = await bookDocReceiver.get();

      if (bookSender.exists &&
          bookSender.data()!['category'] == 'Tukar Pinjam') {
        await bookDocSender.update({
          'loan_end_time': loanEndTime,
        });
      }

      if (bookReceiver.exists &&
          bookReceiver.data()!['category'] == 'Tukar Pinjam') {
        await bookDocReceiver.update({
          'loan_end_time': loanEndTime,
        });
      }

      // Notify the sender
      UserModel sender = await fetchRequestedUser(request.senderId);
      UserModel receiver = await fetchRequestedUser(request.receiverId);
      await sendPushNotification(
          sender, 'Pengajuan Tukar Pinjam diterima oleh ${receiver.fullName}.');

      // Schedule a task to remove loan_end_time after the loan duration
      scheduleLoanEndTimeRemoval(request.senderBookId, loanEndTime.toDate());
      scheduleLoanEndTimeRemoval(request.receiverBookId, loanEndTime.toDate());
    } catch (e) {
      print('Error accepting tukar pinjam request: $e');
    }
  }

  void scheduleLoanEndTimeRemoval(String bookId, DateTime loanEndTime) {
    final duration = loanEndTime.difference(DateTime.now());

    Future.delayed(duration, () async {
      final bookDoc =
          FirebaseFirestore.instance.collection('books').doc(bookId);
      final bookData = await bookDoc.get();

      if (bookData.exists && bookData.data()!['loan_end_time'] != null) {
        await bookDoc.update({
          'loan_end_time': FieldValue.delete(),
        });

        // Update the status to "Selesai" in TukarPinjam collection
        final tukarPinjamDoc = await FirebaseFirestore.instance
            .collection('TukarPinjam')
            .where('senderBookId', isEqualTo: bookId)
            .get();

        if (tukarPinjamDoc.docs.isNotEmpty) {
          for (var doc in tukarPinjamDoc.docs) {
            await doc.reference.update({
              'status': 'Selesai',
            });
          }
        }

        final tukarPinjamDocReceiver = await FirebaseFirestore.instance
            .collection('TukarPinjam')
            .where('receiverBookId', isEqualTo: bookId)
            .get();

        if (tukarPinjamDocReceiver.docs.isNotEmpty) {
          for (var doc in tukarPinjamDocReceiver.docs) {
            await doc.reference.update({
              'status': 'Selesai',
            });
          }
        }
      }
    });
  }

  Future<void> rejectTukarPinjamRequest(TukarPinjamModel request) async {
    try {
      // Notify the sender
      UserModel receiver = await fetchRequestedUser(request.receiverId);
      UserModel sender = await fetchRequestedUser(request.senderId);
      await sendPushNotification(
          sender, 'Pengajuan Tukar Pinjam ditolak oleh ${receiver.fullName}.');

      // Delete the request document from the collection
      await FirebaseFirestore.instance
          .collection('TukarPinjam')
          .doc(request.id)
          .delete();
    } catch (e) {
      print('Error rejecting tukar pinjam request: $e');
    }
  }

  Future<void> sendPushNotification(UserModel chatUser, String msg) async {
    try {
      final body = {
        "message": {
          "token": chatUser.pushToken,
          "notification": {
            "title": 'Tukar Pinjam',
            "body": msg,
          },
        }
      };

      const projectID = 'simarku-a8d45';
      final bearerToken = await NotificationAccessToken.getToken;
      log('bearerToken: $bearerToken');

      if (bearerToken == null) {
        log('Error: OAuth 2 access token is null or expired');
        return;
      }

      var res = await post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectID/messages:send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
        },
        body: jsonEncode(body),
      );

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'chats', // channel id
                'Chats', // channel name
                importance: Importance.max,
                priority: Priority.high,
                showWhen: true,
              ),
            ),
          );
        }
      });

      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotification Error: $e');
    }
  }

  Future<void> showMyBookDialog(BuildContext context) async {
    List<StoryModel> bookList = [];
    try {
      final user = AuthRepository.instance.authUser;
      if (user == null) {
        throw 'User tidak login';
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('owner_id', arrayContains: user.uid)
          .where('category', isEqualTo: 'Tukar Pinjam')
          .get();
      bookList = querySnapshot.docs
          .map((doc) => StoryModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching book data: $e');
    }

    if (bookList.isEmpty) {
      SMLoaders.errorSnackBar(
          title: 'Tidak Ada Buku',
          message: 'Tambah koleksi buku kamu terlebih dahulu.');
      return;
    }

    RxString selectedBookId = ''.obs;
    RxString selectedBookName = ''.obs;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Pilih Buku',
            style: AppTextStyle.body2Medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.neutral02,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    bookList[index].name!,
                    style: AppTextStyle.body3Regular,
                  ),
                  trailing: Obx(() => Radio<String>(
                        activeColor: AppColors.primary,
                        value: bookList[index].id!,
                        groupValue: selectedBookId.value,
                        onChanged: (String? value) {
                          if (value != null) {
                            selectedBookId.value = value;
                            selectedBookName.value = bookList[index].name!;
                          }
                        },
                      )),
                );
              },
            ),
          ),
          actions: [
            SMElevatedButton(
                onPressed: () {
                  if (selectedBookId.value.isNotEmpty) {
                    this.selectedBookId.value = selectedBookId.value;
                    this.selectedBookName.value = selectedBookName.value;
                    ownerController.text = selectedBookName.value;
                    Get.back();
                  } else {
                    showCustomToast(
                      message: 'Pilih Buku...',
                      title: 'Error',
                    );
                  }
                },
                labelText: 'Pilih')
          ],
        );
      },
    );
  }
}
