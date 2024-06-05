import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class DonationBookPage extends StatelessWidget {
  const DonationBookPage({super.key});

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
          'Donasi Buku',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Center(
        child: Text(
          'Tidak ada buku donasi',
          style: AppTextStyle.body3Regular,
        ),
      ),
    );
  }
}
