import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simarku/controllers/tukar_milik/tukar_milik_controller.dart';
import 'package:simarku/features/activity/widgets/widgets.dart';
import 'package:simarku/features/books/tukar_milik/screen/all_tukar_milik_view.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class DiajukanTukarMilikWidget extends StatefulWidget {
  const DiajukanTukarMilikWidget({super.key});

  @override
  _DiajukanTukarMilikWidgetState createState() =>
      _DiajukanTukarMilikWidgetState();
}

class _DiajukanTukarMilikWidgetState extends State<DiajukanTukarMilikWidget> {
  Future<void> _refreshData() async {
    setState(() {});
  }

  Future<UserModel> fetchUserDetails(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (!userDoc.exists) {
      throw 'User not found in Firestore';
    }
    return UserModel.fromFirestore(userDoc);
  }

  Future<StoryModel> fetchBookDetails(String bookId) async {
    DocumentSnapshot bookDoc =
        await FirebaseFirestore.instance.collection('books').doc(bookId).get();
    if (!bookDoc.exists) {
      throw 'Book not found in Firestore';
    }
    return StoryModel.fromFirestore(bookDoc);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TukarMilikController());
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (!authSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final currentUser = authSnapshot.data!;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('TukarMilik')
              .where('senderId', isEqualTo: currentUser.uid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kamu belum pernah melakukan tukar milik. Ayo ajukan tukar milik sekarang!',
                        style: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.neutral08),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SMElevatedButton(
                        onPressed: () {
                          Get.to(() => AllTukarMilikView());
                        },
                        labelText: 'Tukar Milik Buku',
                        width: 185,
                      ),
                    ],
                  ),
                ),
              );
            }
            final requests = snapshot.data!.docs
                .map((doc) => TukarMilikModel.fromFirestore(doc))
                .toList();
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return FutureBuilder<UserModel>(
                    future: fetchUserDetails(request.receiverId),
                    builder: (context, senderSnapshot) {
                      if (!senderSnapshot.hasData) {
                        return ListTile(
                          title: Text('Loading...'),
                          subtitle: Text('Status: ${request.status}'),
                        );
                      }
                      final sender = senderSnapshot.data!;
                      return FutureBuilder<StoryModel>(
                        future: fetchBookDetails(request.receiverBookId),
                        builder: (context, bookSnapshot) {
                          if (!bookSnapshot.hasData) {
                            return ListTile(
                              title: Text('Loading...'),
                              subtitle: Text('Status: ${request.status}'),
                            );
                          }
                          final book = bookSnapshot.data!;
                          final formattedTimestamp = DateFormat.yMMMMd('id_ID')
                              .addPattern(',')
                              .add_jm()
                              .format(request.timestamp.toDate());
                          return InkWell(
                            onTap: () => Get.to(() => DetailBook(book: book)),
                            child: TukarMilikCard(
                                isSender: true,
                                book: book,
                                sender: sender,
                                formattedTimestamp: formattedTimestamp,
                                request: request,
                                currentUser: currentUser,
                                controller: controller),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
