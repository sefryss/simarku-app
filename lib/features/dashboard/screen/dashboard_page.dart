import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:simarku/controllers/auth/user_controller.dart';
import 'package:simarku/features/article/screen/all_article/screen/all_article_page.dart';
import 'package:simarku/features/dashboard/widgets/widgets.dart';

import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/routes/app_router.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: AppColors.primary,
                  height: 220,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 64, 16, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              final networkImage =
                                  controller.user.value.profilePicture;
                              final image = networkImage;
                              return controller.imageUploading.value
                                  ? const SMShimmerWidget(height: 56, width: 56)
                                  : SMCircularImage(
                                      image: image,
                                      // width: 80,
                                      // height: 80,
                                      isNetworkImage: networkImage.isNotEmpty,
                                    );
                            }),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              flex: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    if (controller.profileLoading.value) {
                                      return SMShimmerWidget(
                                          height: 15, width: 150);
                                    } else {
                                      return Text(
                                        'Halo, ${controller.user.value.fullName}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.body1SemiBold
                                            .copyWith(color: Colors.white),
                                      );
                                    }
                                  }),
                                  Text(
                                    'Sudah siap mencari buku \nkesukaanmu?',
                                    style: AppTextStyle.body3Regular
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/icon_pesan.svg',
                              width: 36.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CarouselSliderWithIndicator(),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fitur',
                    style: AppTextStyle.body2Medium,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  MainFeature(),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Rekomendasi Buku',
                    style: AppTextStyle.body2Medium,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  BookRecommendation(),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Kegiatan Literasi',
                    style: AppTextStyle.body2Medium,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  LiteracyActivity(),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sekilas Ilmu',
                        style: AppTextStyle.body2Medium,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => AllArticlePage());
                        },
                        child: Text(
                          'Lebih Banyak',
                          style: AppTextStyle.body3Medium
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ListArticle(),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
