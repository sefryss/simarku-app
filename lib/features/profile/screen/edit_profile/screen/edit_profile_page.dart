import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/auth/edit_user_controller.dart';
import 'package:simarku/controllers/auth/user_controller.dart';
import 'package:simarku/features/profile/screen/edit_profile/widgets/address_input_dart.dart';
import 'package:simarku/features/profile/screen/edit_profile/widgets/email_input_widget.dart';
import 'package:simarku/features/profile/screen/edit_profile/widgets/name_input_widget.dart';
import 'package:simarku/features/profile/screen/edit_profile/widgets/nik_input_widget.dart';
import 'package:simarku/features/profile/screen/edit_profile/widgets/phone_input_widget.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditUserController());
    final userController = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: SMBackButton(),
        title: Text(
          'Edit Profil',
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
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Center(
                    child: SizedBox.square(
                      dimension: 124.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Obx(() {
                            final networkImage =
                                userController.user.value.profilePicture;
                            final image = networkImage;
                            return userController.imageUploading.value
                                ? const SMShimmerWidget(
                                    height: 56,
                                    width: 56,
                                    radius: 100,
                                  )
                                : SMCircularImage(
                                    image: image,
                                    // width: 80,
                                    // height: 80,
                                    isNetworkImage: networkImage.isNotEmpty,
                                  );
                            // InkWell(
                            //   onTap: () =>
                            //       userController.uploadProfilePicture(),
                            //   child: Container(
                            //       clipBehavior: Clip.hardEdge,
                            //       decoration: const BoxDecoration(
                            //           shape: BoxShape.circle),
                            //       child: Image.asset('assets/images/topi.jpg')),
                            // );
                          }),
                          _buildButton(
                            onTap: () => userController.uploadProfilePicture(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    userController.user.value.fullName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heading5SemiBold,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    userController.user.value.email,
                    style: AppTextStyle.body3Regular,
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Form(
                key: controller.editUserFormKey,
                child: Column(
                  children: [
                    const ProfileEmailInputWidget(),
                    const SizedBox(height: 16.0),
                    const ProfileNameInputWidget(),
                    const SizedBox(height: 16.0),
                    const ProfileNIKInputWidget(),
                    const SizedBox(height: 16.0),
                    const ProfilePhoneInputWidget(),
                    const SizedBox(height: 16.0),
                    const ProfileAddressInputWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              SMElevatedButton(
                onPressed: () => controller.updateUser(),
                labelText: 'Simpan',
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Align _buildButton({required VoidCallback? onTap}) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      height: 35,
      width: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.red,
      ),
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.camera_alt_rounded,
          size: 16.0,
          color: AppColors.n1White,
        ),
      ),
    ),
  );
}

// void _pickFile(BuildContext context) {
//   showModalBottomSheet<ImageSource>(
//     context: context,
//     builder: (context) => Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             'Ganti foto profil',
//             style:
//                 AppTextStyle.body2SemiBold.copyWith(color: AppColors.n1Black),
//           ),
//         ),
//         const Divider(),
//         ButtonBar(
//           alignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               onPressed: () => ImageSource.camera,
//               icon: const Icon(Icons.camera_alt_outlined),
//               tooltip: 'Kamera',
//             ),
//             IconButton(
//               onPressed: () => ImageSource.gallery,
//               icon: const Icon(Icons.image_outlined),
//               tooltip: 'Galeri',
//             ),
//           ],
//         ),
//         const SizedBox(height: 16.0),
//       ],
//     ),
//     isScrollControlled: true,
//     showDragHandle: true,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
//   );
// }


  // .then(
  //   (source) => source != null
  //       ? context
  //           .read<EditProfileBloc>()
  //           .add(EditProfileEvent.pickFileEvent(source))
  //       : null,
  // );