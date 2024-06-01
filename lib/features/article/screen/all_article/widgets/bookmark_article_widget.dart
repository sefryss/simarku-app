import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/sekilas_info/sekilas_info_controller.dart';
import 'package:simarku/features/article/screen/all_article/widgets/widgets.dart';
import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';

class BookmarkArticle extends StatelessWidget {
  const BookmarkArticle({super.key});

  @override
  Widget build(BuildContext context) {
    final SekilasInfoController controller = Get.put(SekilasInfoController());
    return Obx(() {
      if (controller.bookMarkList.isEmpty) {
        return Center(
          child: Text(
            'Tidak ada sekilas info favorit',
            style: AppTextStyle.body1Regular,
          ),
        );
      }
      return Container(
        height: 134,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('sekilas_info').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Tidak ada data.'));
            }
            var favSekilasInfo = snapshot.data!.docs.where((doc) {
              return controller.bookMarkList.contains(doc.id);
            }).toList();

            if (favSekilasInfo.isEmpty) {
              return Center(
                  child: Text(
                'Tidak ada sekilas info favorit',
                style: AppTextStyle.body2Regular,
              ));
            }
            return SizedBox(
              height: 134,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var sekilasInfo =
                      SekilasInfoModel.fromFirestore(favSekilasInfo[index]);
                  return InkWell(
                      onTap: () {
                        Get.to(() => DetailArticle(article: sekilasInfo));
                      },
                      child: ArticleCard(article: sekilasInfo));
                },
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: favSekilasInfo.length,
              ),
            );
          },
        ),
      );
    });
  }
}
