import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:simarku/utils/constantWidget.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailKegiatanLiterasi extends StatelessWidget {
  final KegiatanLiterasiModel kegiatanLiterasi;

  const DetailKegiatanLiterasi({
    super.key,
    required this.kegiatanLiterasi,
  });

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title:
            Text('Kegiatan Literasi', style: TextStyle(color: AppColors.white)),
        leading: SMBackButton(
          buttonColor: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Thumbnail kegiatanLiterasi
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: kegiatanLiterasi.image != null &&
                        kegiatanLiterasi.image!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          kegiatanLiterasi.image!,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.neutral03),
                          color: Colors.grey[200],
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sumber: ${kegiatanLiterasi.source}',
                style: AppTextStyle.body3Regular,
              ),
              const SizedBox(height: 10),
              Text(
                'Tanggal: ${kegiatanLiterasi.date!}',
                style: AppTextStyle.body3Regular
                    .copyWith(color: AppColors.neutral06),
              ),
              const SizedBox(height: 16),
              Text(
                kegiatanLiterasi.title!,
                style: AppTextStyle.body2SemiBold,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              HtmlWidget(
                decode(
                  kegiatanLiterasi.desc!,
                ),
                textStyle: AppTextStyle.body3Regular
                    .copyWith(color: AppColors.neutral08),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (kegiatanLiterasi.url != null &&
                  kegiatanLiterasi.url!.isNotEmpty) {
                launchURL(kegiatanLiterasi.url!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('URL tidak tersedia')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Lihat Detail',
                textAlign: TextAlign.center,
                style:
                    AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
