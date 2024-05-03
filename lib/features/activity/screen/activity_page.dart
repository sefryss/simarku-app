import 'package:flutter/material.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';
import 'package:simarku/features/profile/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Aktivitas',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              ProfileMenuWidget(
                icon: 'assets/icons/icon_tukar_pinjam.svg',
                title: 'History Tukar Pinjam',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_tukar_milik.svg',
                title: 'History Tukar Milik',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_donasi.svg',
                title: 'History Donasi',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_favorite_book_activity.svg',
                title: 'Buku Favorit',
                onTap: () {},
              ),
            ],
          )),
    );
  }
}
