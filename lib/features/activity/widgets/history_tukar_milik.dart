import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simarku/controllers/tukar_milik/tukar_milik_controller.dart';
import 'package:simarku/features/activity/widgets/widgets.dart';
import 'package:simarku/features/books/tukar_milik/screen/all_tukar_milik_view.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryTukarMilik extends StatelessWidget {
  const HistoryTukarMilik({Key? key});

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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: SMBackButton(
            buttonColor: Colors.white,
          ),
          title: Text(
            'Riwayat Tukar Milik',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengajuan',
                    style: AppTextStyle.body2Medium,
                  ),
                  //   InkWell(
                  //     //   onTap: () => Get.to(() => EBookView()),
                  //     child: Text(
                  //       'Lihat Semua',
                  //       style: AppTextStyle.body3Medium
                  //           .copyWith(color: AppColors.primary),
                  //     ),
                  //   ),
                ],
              ),
            ),
            Expanded(child: PengajuanTukarMilikWidget()),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Diajukan',
                    style: AppTextStyle.body2Medium,
                  ),
                  //   InkWell(
                  //     //   onTap: () => Get.to(() => EBookView()),
                  //     child: Text(
                  //       'Lihat Semua',
                  //       style: AppTextStyle.body3Medium
                  //           .copyWith(color: AppColors.primary),
                  //     ),
                  //   ),
                ],
              ),
            ),
            Expanded(child: DiajukanTukarMilikWidget()),
          ],
        ));
  }
}
