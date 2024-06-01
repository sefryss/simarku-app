import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';
import 'package:simarku/models/sekilas_info_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

class ListArticle extends StatelessWidget {
  const ListArticle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                  onTap: () => Get.to(
                        () => DetailArticle(
                          article: sekilasInfoList[index],
                        ),
                      ),
                  child: _ArticleCard(article: sekilasInfoList[index])),
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              itemCount: sekilasInfoList.length,
            ),
          );
        },
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final SekilasInfoModel article;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Center(
        child: Container(
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.neutral03),
                    ),
                    child: article.image != null && article.image!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.image!,
                              fit: BoxFit.cover,
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
                ),
                const SizedBox(height: 14),
                Text(
                  article.date ?? '',
                  style: AppTextStyle.body3Regular,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  article.title ?? '',
                  style: AppTextStyle.body2SemiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  article.author ?? '',
                  style: AppTextStyle.body3Regular,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
