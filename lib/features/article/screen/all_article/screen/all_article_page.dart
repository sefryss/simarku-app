import 'package:flutter/material.dart';
import 'package:simarku/features/article/screen/all_article/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/sm_back_button.dart';

class AllArticlePage extends StatelessWidget {
  const AllArticlePage({
    super.key,
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ArticleTabBar(),
            Expanded(
              child: TabBarView(
                physics: ScrollPhysics(),
                children: [
                  AllArticle(),
                  BookmarkArticle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
