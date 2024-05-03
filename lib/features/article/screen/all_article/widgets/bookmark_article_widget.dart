import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/article/screen/all_article/widgets/widgets.dart';
import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';

import 'package:simarku/models/models.dart';
import 'package:simarku/routes/app_router.dart';

class BookmarkArticle extends StatelessWidget {
  const BookmarkArticle({super.key});

  @override
  Widget build(BuildContext context) {
    List<Article> filteredArticleList =
        List<Article>.from(articleList).sublist(0, 3);
    return SizedBox(
      height: 134,
      child: ListView.separated(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.to(() => DetailArticle(article: filteredArticleList[index]));
            },
            child: ArticleCard(article: filteredArticleList[index])),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: filteredArticleList.length,
      ),
    );
  }
}
