import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simarku/controllers/tukar_pinjam/tukar_pinjam_controller.dart';
import 'package:simarku/features/activity/widgets/riwayat_tukar_pinjam/tukar_pinjam_card.dart';
import 'package:simarku/features/books/tukar_pinjam/screen/all_tukar_pinjam_view.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class DiajukanTukarPinjamWidget extends StatelessWidget {
  const DiajukanTukarPinjamWidget({super.key});

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
    final controller = Get.put(TukarPinjamController());
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (!authSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final currentUser = authSnapshot.data!;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('TukarPinjam')
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
                        'Kamu belum pernah melakukan tukar pinjam. Ayo ajukan tukar pinjam sekarang!',
                        style: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.neutral08),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SMElevatedButton(
                        onPressed: () {
                          Get.to(() => AllTukarPinjamView());
                        },
                        labelText: 'Tukar Pinjam Buku',
                        width: 185,
                      ),
                    ],
                  ),
                ),
              );
            }
            final requests = snapshot.data!.docs
                .map((doc) => TukarPinjamModel.fromFirestore(doc))
                .toList();
            return ListView.builder(
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
                        final loanEndTime = DateFormat.yMMMMd('id_ID')
                            .format(request.loanEndTime.toDate());
                        return InkWell(
                          onTap: () => Get.to(() => DetailBook(book: book)),
                          child: TukarPinjamCard(
                              loanEndTime: loanEndTime,
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
            );
          },
        );
      },
    );
  }
}
