import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simarku/features/donation_book/screen/add_donation_book_page.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class HistoryDonationBook extends StatelessWidget {
  const HistoryDonationBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Riwayat Donasi',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/empty.svg',
                height: 300,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Kamu belum berdonasi buku apapun,\nAyo donasikan buku kamu disini!',
                style: AppTextStyle.body1Regular,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              SMElevatedButton(
                onPressed: () {
                  Get.to(() => AddDonationBookPage());
                },
                labelText: 'Donasi Buku',
                width: 185,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
