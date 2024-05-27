import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SMAnimationLoaderWidget extends StatelessWidget {
  const SMAnimationLoaderWidget({
    super.key,
    // required this.text,
    // this.showAction = false,
    // this.actionText,
    required this.animation,
    // this.onActionPressed,
  });

//   final String text;
  final String animation;
//   final bool showAction;
//   final String? actionText;
//   final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(
            height: 24,
          ),
          //   Text(
          //     text,
          //     style:
          //         AppTextStyle.body3Medium.copyWith(color: AppColors.neutral04),
          //     textAlign:
          //         TextAlign.center, // Atur teks ke tengah secara horizontal
          //     maxLines: null, // Hapus batasan jumlah baris
          //   ),
          //   const SizedBox(
          //     height: 24,
          //   ),
          //   if (showAction)
          //     SizedBox(
          //       width: 250,
          //       child: OutlinedButton(
          //         onPressed: onActionPressed,
          //         style: OutlinedButton.styleFrom(
          //           backgroundColor: AppColors.primary,
          //         ),
          //         child: Text(
          //           actionText!,
          //           style:
          //               AppTextStyle.body2Medium.copyWith(color: AppColors.white),
          //         ),
          //       ),
          //     ),
        ],
      ),
    );
  }
}
