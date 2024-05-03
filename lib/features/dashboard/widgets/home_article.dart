import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

class HomeArticle extends StatelessWidget {
  const HomeArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        children: [
          _TitleSection(),
          ListArticle(),
        ],
      ),
    );
  }
}

class ListArticle extends StatelessWidget {
  const ListArticle();

  @override
  Widget build(BuildContext context) {
    List<Article> filteredArticlekList =
        List<Article>.from(articleList).sublist(0, 6);
    return SizedBox(
      height: 300,
      child: ListView.separated(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
            onTap: () => Get.to(
                  () => DetailArticle(
                    article: filteredArticlekList[index],
                  ),
                ),
            child: _ArticleCard(article: filteredArticlekList[index])),
        separatorBuilder: (context, index) => const SizedBox(
          width: 16,
        ),
        itemCount: filteredArticlekList.length,
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Artikel',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      trailing: InkWell(
        onTap: () {},
        child: const Text(
          'Lebih Banyak',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final Article article;

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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        article.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  article.createdAt,
                  style: AppTextStyle.body3Regular,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  article.title,
                  style: AppTextStyle.body2SemiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  article.author,
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
