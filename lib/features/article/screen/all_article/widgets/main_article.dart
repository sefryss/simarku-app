import 'package:flutter/material.dart';
import 'package:simarku/features/article/screen/all_article/widgets/widgets.dart';

class MainArticle extends StatelessWidget {
  const MainArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          SearchArticle(),
          SizedBox(
            height: 16,
          ),
          AllArticle()
        ],
      )),
    );
  }
}
