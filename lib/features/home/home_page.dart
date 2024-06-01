// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simarku/features/activity/screen/activity_page.dart';
import 'package:simarku/features/dashboard/screen/dashboard_page.dart';

import 'package:simarku/features/profile/screen/profile_page.dart';
import 'package:simarku/features/search/screen/search_page.dart';
import 'package:simarku/utils/global/app_config.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: 80,
          backgroundColor: Colors.white,
          indicatorColor: Color.fromARGB(33, 230, 78, 78),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(
              // ignore: deprecated_member_use_from_same_package
              icon: SvgPicture.asset(
                'assets/icons/beranda.svg',
                color: AppColors.neutral04,
              ),
              label: 'Beranda',
              // ignore: deprecated_member_use_from_same_package
              selectedIcon: SvgPicture.asset(
                'assets/icons/beranda.svg',
                color: AppColors.primary,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/jelajah.svg'),
              label: 'Jelajah',
              selectedIcon: SvgPicture.asset(
                'assets/icons/jelajah.svg',
                color: AppColors.primary,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/aktivitas.svg',
                width: 28,
              ),
              label: 'Aktivitas',
              selectedIcon: SvgPicture.asset(
                'assets/icons/aktivitas.svg',
                width: 28,
                color: AppColors.primary,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/profil.svg',
                width: 26,
              ),
              label: 'Akun',
              // ignore: deprecated_member_use_from_same_package
              selectedIcon: SvgPicture.asset(
                'assets/icons/profil.svg',
                width: 26,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const DashboardPage(),
    const SearchPage(),
    const ActivityPage(),
    const ProfilePage()
  ];
}
