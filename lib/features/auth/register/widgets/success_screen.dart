import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class SuccessScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const SuccessScreen({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              56 * 2,
              24,
              0,
            ),
            child: Column(
              children: [
                /// Image
                /// Image
                // Image(
                //   image: AssetImage(
                //     'assets/animations/success_animation.gif',
                //   ),
                //   width: MediaQuery.of(Get.context!).size.width * 0.8,
                // ),
                Lottie.asset(
                  'assets/animations/success.json',
                  width: MediaQuery.of(Get.context!).size.width * 0.8,
                ),
                const SizedBox(
                  height: 32,
                ),

                /// Title
                Text(
                  'Akun Kamu Berhasil Dibuat',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.heading4SemiBold,
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Sub Title
                Text(
                  'Selamat Datang di SiMarKu. Akun Kamu Berhasil Dibuat. Silahkan memulai dan mencari buku yang kamu inginkan. Sekarang kamu bisa melakukan Tukar Pinjam, Tukar Milik, serta Donasi Buku',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body3Regular
                      .copyWith(color: AppColors.neutral06),
                ),
                const SizedBox(
                  height: 24,
                ),

                /// Button
                SMElevatedButton(
                  onPressed: onPressed,
                  labelText: 'Masuk Kembali',
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
