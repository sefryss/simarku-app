import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              width: 132,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(article.thumbnail),
                ),
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
                    article.createdAt,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.title,
                    style: AppTextStyle.body2SemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        article.author,
                        style: AppTextStyle.body3Medium
                            .copyWith(color: AppColors.neutral06),
                      ),
                      const Spacer(),
                      Icon(
                        article.isFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: AppColors.primary,
                        // size: 16,
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
