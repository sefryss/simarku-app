import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/utils/global/app_config.dart';

class BookImageWidget extends StatelessWidget {
  const BookImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
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
                : (controller.imageController.text.isNotEmpty)
                    ? Container(
                        height: 170,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.neutral02,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            controller.storyModel!.image!,
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
