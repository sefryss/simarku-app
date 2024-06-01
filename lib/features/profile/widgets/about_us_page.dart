import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
          'Tentang Kami',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                // color: AppColors.neutral02,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.primary), // Outline border warna hitam
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SiMarKu adalah sebuah platform yang menjembatani para penggiat dan penikmat literasi dengan cara menyediakan wadah untuk meminjam, menukar, dan mendonasikan buku mereka. Platform ini hadir sebagai solusi inovatif untuk meningkatkan aksesibilitas terhadap buku dan mendorong budaya membaca di masyarakat.',
                    style: AppTextStyle.body2Regular,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Misi:',
                    style: AppTextStyle.body1Medium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Meningkatkan literasi dan kemudahan akses dunia pengetahuan dengan memanfaatkan teknologi.',
                    style: AppTextStyle.body2Regular,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Visi:',
                    style: AppTextStyle.body1Medium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menjadi platform literasi terdepan yang memberdayakan masyarakat melalui akses buku yang mudah dan terjangkau, serta membangun komunitas yang inklusif dan inspiratif.',
                    style: AppTextStyle.body2Regular,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
