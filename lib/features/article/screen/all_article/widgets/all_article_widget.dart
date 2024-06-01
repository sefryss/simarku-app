import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/controllers/sekilas_info/sekilas_info_controller.dart';
import 'package:simarku/features/article/screen/all_article/widgets/widgets.dart';
import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';

import 'package:simarku/models/models.dart';

class AllArticle extends StatelessWidget {
  const AllArticle({super.key});

  @override
  Widget build(BuildContext context) {
    final SekilasInfoController controller = Get.put(SekilasInfoController());
    SekilasInfoModel article = SekilasInfoModel();
    Future.delayed(Duration.zero, () async {
      controller.getFavDataList();
      controller.getBookMarkList();
    });

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInFav(article.id.toString());
      },
    );

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInBookMark(article.id.toString());
      },
    );
    return Container(
      height: 134,
      child: StreamBuilder<QuerySnapshot>(
        stream: FireBaseData.getSekilasInfoList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<SekilasInfoModel> sekilasInfoList = snapshot.data!.docs
              .map((doc) => SekilasInfoModel.fromFirestore(doc))
              .toList();
          return SizedBox(
            height: 134,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Get.to(
                          () => DetailArticle(article: sekilasInfoList[index]));
                    },
                    child: ArticleCard(article: sekilasInfoList[index]));
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: sekilasInfoList.length,
            ),
          );
        },
      ),
    );
  }
}
