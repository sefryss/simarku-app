import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/donation_book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';

class DonationBookImageWidget extends StatelessWidget {
  const DonationBookImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationBookController());
    return Center(
      child: InkWell(
        onTap: () {
          controller.imgFromGallery();
        },
        child: Obx(
          () {
            return (controller.isImageOffline.value)
                ? Container(
                    height: 170,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral02,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        controller.webImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(
                    height: 170,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral02,
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.primary,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
