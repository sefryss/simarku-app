import 'package:flutter/material.dart';

import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailArticle extends StatelessWidget {
  final Article article;

  const DetailArticle({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text('Sekilas Ilmu', style: TextStyle(color: AppColors.white)),
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
              //Thumbnail Article
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.symmetric(vertical: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    article.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.author,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  Text(
                    article.createdAt,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      style: AppTextStyle.body2SemiBold,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    article.isFavorite
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: AppColors.primary,
                    // size: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // Text(
              //   article.content,
              //   style: AppTextStyle.body3Regular,
              // ),
              Html(
                data: article.content,
                style: {
                  "h1": Style(
                      fontSize: FontSize(18), fontWeight: FontWeight.w600),
                  "h2": Style(
                      fontSize: FontSize(16), fontWeight: FontWeight.w600),
                  "strong<li>": Style(
                      fontSize: FontSize(14), fontWeight: FontWeight.w600),
                  "li": Style(
                    fontSize: FontSize(14),
                  ),
                  "p": Style(
                    fontSize: FontSize(14),
                  ),
                  "body":
                      Style(padding: HtmlPaddings.zero, margin: Margins.zero)
                },
                doNotRenderTheseTags: const {"hr"},
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
