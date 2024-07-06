import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary),
              ),
              child: Html(
                data: '''
                  <p style="text-align: justify;">
                    SiMarKu adalah sebuah platform yang menjembatani para penggiat dan penikmat literasi dengan cara menyediakan wadah untuk meminjam, menukar, dan mendonasikan buku mereka. Platform ini hadir sebagai solusi inovatif untuk meningkatkan aksesibilitas terhadap buku dan mendorong budaya membaca di masyarakat.
                  </p>
                  <h2>Visi:</h2>
                  <p style="text-align: justify;">
                    Menjadi platform literasi terdepan yang memberdayakan masyarakat melalui akses buku yang mudah dan terjangkau, serta membangun komunitas yang inklusif dan inspiratif.
                  </p>
                  <h2>Misi:</h2>
                  <p style="text-align: justify;">
                    Meningkatkan literasi dan kemudahan akses dunia pengetahuan dengan memanfaatkan teknologi.
                  </p>
                ''',
                style: {
                  "p": Style(
                    fontSize: FontSize.large,
                    color: AppColors.black,
                  ),
                  "h2": Style(
                    fontSize: FontSize.larger,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
