import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/utils/shared_widgets/sm_animation_widget.dart';

class SMFullScreenLoader {
  static void openLoadingDialog( String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              SMAnimationLoaderWidget(animation: animation)
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
