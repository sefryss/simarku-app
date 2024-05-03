import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_colors.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class SMCircularImage extends StatelessWidget {
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlaycolor;
  final Color? backgroundColor;
  final double width, height;
  const SMCircularImage(
      {super.key,
      this.width = 56,
      this.height = 56,
      this.overlaycolor,
      this.backgroundColor,
      required this.image,
      this.fit = BoxFit.cover,
      this.isNetworkImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    color: overlaycolor,
                    progressIndicatorBuilder:
                        (context, url, downloadProggres) => SMShimmerWidget(
                      height: 56,
                      width: 56,
                      radius: 100,
                    ),
                    errorWidget: ((context, url, error) =>
                        const Icon(Icons.error)),
                  )
                : Image.asset('assets/images/profile-placeholder.png')),
      ),
    );
  }
}
