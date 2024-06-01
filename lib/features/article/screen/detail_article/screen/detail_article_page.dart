import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/sekilas_info/sekilas_info_controller.dart';
import 'package:simarku/models/sekilas_info_model.dart';

import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailArticle extends StatefulWidget {
  final SekilasInfoModel article;

  const DetailArticle({
    super.key,
    required this.article,
  });

  @override
  State<DetailArticle> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  final SekilasInfoController controller = Get.put(SekilasInfoController());

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      controller.getFavDataList();
      controller.getBookMarkList();
    });

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInFav(widget.article.id.toString());
      },
    );

    Future.delayed(
      Duration.zero,
      () {
        controller.checkInBookMark(widget.article.id.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SekilasInfoController controller = Get.put(SekilasInfoController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text('Sekilas Info', style: TextStyle(color: AppColors.white)),
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
                height: 350,
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.symmetric(vertical: 16),
                child: widget.article.image != null &&
                        widget.article.image!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.article.image!,
                          fit: BoxFit.fill,
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
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.article.author!,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  Text(
                    widget.article.date!,
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
                      widget.article.title!,
                      style: AppTextStyle.body2SemiBold,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        size: 28,
                        color: AppColors.primary,
                        controller.save.value
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                      ),
                      onPressed: () {
                        controller.checkInBookMarkList(widget.article);
                        controller.checkInBookMark(widget.article.id ?? "");
                        if (controller.save.value) {
                          SMLoaders.successSnackBar(
                              message: 'Ditandai sebagai favorit',
                              title: 'Berhasil');
                        } else {
                          SMLoaders.errorSnackBar(
                              message: 'Dihapus dari favorit',
                              title: 'Berhasil');
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Sumber: ${widget.article.source}',
                style: AppTextStyle.body3Regular,
              ),
              const SizedBox(
                width: 24,
              ),
              Html(
                data: widget.article.desc!,
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
