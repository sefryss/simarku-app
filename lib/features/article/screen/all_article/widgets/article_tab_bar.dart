import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

class ArticleTabBar extends StatelessWidget {
  const ArticleTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'Artikel',
      'Disimpan',
    ];

    return TabBar(
      indicatorWeight: 2.0,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppTextStyle.body3Medium,
      labelColor: AppColors.primary,
      labelPadding: const EdgeInsets.all(16.0),
      unselectedLabelColor: AppColors.neutral05,
      tabs: List.generate(
        tabs.length,
        (index) => Text(tabs[index]),
      ),
    );
  }
}
