import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/activity/widgets/history_donation_book.dart';
import 'package:simarku/features/activity/widgets/riwayat_tukar_milik/history_tukar_milik.dart';
import 'package:simarku/features/activity/widgets/widgets.dart';
import 'package:simarku/features/profile/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Aktivitas',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riwayat',
                  style: AppTextStyle.body2Medium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16,
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/icon_tukar_pinjam.svg',
                  title: 'Riwayat Tukar Pinjam',
                  onTap: () {
                    Get.to(() => HistoryTukarPinjam());
                  },
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/icon_tukar_milik.svg',
                  title: 'Riwayat Tukar Milik',
                  onTap: () {
                    Get.to(() => HistoryTukarMilik());
                  },
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/icon_donasi.svg',
                  title: 'Riwayat Donasi',
                  onTap: () {
                    Get.to(() => HistoryDonationBook());
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Buku',
                  style: AppTextStyle.body2Medium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16,
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/book.svg',
                  title: 'Buku Saya',
                  onTap: () {
                    Get.to(() => MyBook());
                  },
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/icon_favorite_book_activity.svg',
                  title: 'Buku Favorit',
                  onTap: () {
                    Get.to(() => FavouriteBook());
                  },
                ),
                ProfileMenuWidget(
                  icon: 'assets/icons/book.svg',
                  title: 'Baru Saja Dibaca',
                  onTap: () {
                    Get.to(() => RecentBook());
                  },
                ),
              ],
            )),
      ),
    );
  }
}
