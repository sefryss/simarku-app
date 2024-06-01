import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/models/models.dart';

class KegiatanLiterasiCard extends StatelessWidget {
  final KegiatanLiterasiModel kegiatanLiterasi;
  const KegiatanLiterasiCard({
    super.key,
    required this.kegiatanLiterasi,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: 115,
        child: Row(
          children: [
            Container(
              width: 132,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: kegiatanLiterasi.image != null &&
                        kegiatanLiterasi.image!.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(kegiatanLiterasi.image!),
                      )
                    : null,
                color: kegiatanLiterasi.image == null ||
                        kegiatanLiterasi.image!.isEmpty
                    ? Colors.grey[200]
                    : null,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kegiatanLiterasi.date!,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kegiatanLiterasi.title!,
                    style: AppTextStyle.body2SemiBold,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    kegiatanLiterasi.source!,
                    style: AppTextStyle.body3Medium
                        .copyWith(color: AppColors.neutral06),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
