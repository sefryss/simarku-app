
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simarku/utils/global/app_colors.dart';

class SMShimmerWidget extends StatelessWidget {
  final double width, height, radius;
  final Color? color;

  const SMShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    this.radius = 4,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
