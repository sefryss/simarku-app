import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/sekilas_info/sekilas_info_controller.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

class ArticleCard extends StatelessWidget {
  final SekilasInfoModel article;
  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final SekilasInfoController controller = Get.put(SekilasInfoController());

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: 115,
        child: Row(
          children: [
            Container(
              width: 132,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: article.image != null && article.image!.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(article.image!),
                      )
                    : null,
                color: article.image == null || article.image!.isEmpty
                    ? Colors.grey[200]
                    : null,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.date!,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.title!,
                    style: AppTextStyle.body2SemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        article.author!,
                        style: AppTextStyle.body3Medium
                            .copyWith(color: AppColors.neutral06),
                      ),
                      const Spacer(),
                      Obx(
                        () => Icon(
                          color: AppColors.primary,
                          controller.bookMarkList.contains(article.id)
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
