import 'package:flutter/material.dart';
import 'package:simarku/features/activity/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class HistoryTukarMilik extends StatelessWidget {
  const HistoryTukarMilik({Key? key});

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