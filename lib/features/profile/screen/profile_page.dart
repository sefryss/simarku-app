import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/user_controller.dart';
import 'package:simarku/features/profile/screen/edit_profile/screen/edit_profile_page.dart';
import 'package:simarku/features/profile/widgets/widgets.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            24.0,
            16.0,
            16.0,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.all(88),
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Obx(
                          () {
                            final networkImage =
                                controller.user.value.profilePicture;
                            final image = networkImage;
                            return controller.imageUploading.value
                                ? const SMShimmerWidget(
                                    height: 56,
                                    width: 56,
                                    radius: 100,
                                  )
                                : SMCircularImage(
                                    image: image,
                                    width: 200,
                                    height: 200,
                                    isNetworkImage: networkImage.isNotEmpty,
                                  );
                          },
                        ),
                      ),
                    );
                  },
                ),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage;
                        return controller.imageUploading.value
                            ? const SMShimmerWidget(
                                height: 56,
                                width: 56,
                                radius: 100,
                              )
                            : SMCircularImage(
                                image: image,
                                // width: 200,
                                // height: 200,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                controller.user.value.fullName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyle.heading5SemiBold,
              ),

              SizedBox(
                height: 4,
              ),
              Text(
                controller.user.value.email,
                style: AppTextStyle.body3Regular,
              ),
              SizedBox(
                height: 12,
              ),
              SMElevatedButton(
                onPressed: () {
                  Get.to(() => EditProfilePage());
                },
                labelText: 'Edit Profil',
                width: 185,
                borderRadius: BorderRadius.circular(24),
              ),

              const SizedBox(
                height: 32,
              ),

              /// Menu Profile
              ProfileMenuWidget(
                icon: 'assets/icons/icon_about_us.svg',
                title: 'About Us',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_rate_us.svg',
                title: 'Rate Us',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_feedback.svg',
                title: 'FeedBack',
                onTap: () {},
              ),
              ProfileMenuWidget(
                icon: 'assets/icons/icon_tnc.svg',
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),

              SMElevatedButton(
                onPressed: () => AuthRepository.instance.logout(),
                labelText: 'Keluar',
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
