import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/kegiatan_literasi/widgets/detail_kegiatan_literasi.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';

class LiteracyActivity extends StatelessWidget {
  const LiteracyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      child: StreamBuilder<QuerySnapshot>(
        stream: FireBaseData.getKegiatanLiterasiList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<KegiatanLiterasiModel> kegiatanLiterasiList = snapshot.data!.docs
              .map((doc) => KegiatanLiterasiModel.fromFirestore(doc))
              .toList();

          return SizedBox(
            height: 320,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: kegiatanLiterasiList.length,
              itemBuilder: (contaxt, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => DetailKegiatanLiterasi(
                        kegiatanLiterasi: kegiatanLiterasiList[index],
                      ),
                    );
                  },
                  child: _KegiatanLiterasiCard(
                    kegiatanLiterasi: kegiatanLiterasiList[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _KegiatanLiterasiCard extends StatelessWidget {
  const _KegiatanLiterasiCard({
    required this.kegiatanLiterasi,
  });

  final KegiatanLiterasiModel kegiatanLiterasi;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                      '${kegiatanLiterasi.dateStart!} - ${kegiatanLiterasi.dateEnd}',
                      style: AppTextStyle.body3Regular
                          .copyWith(color: AppColors.neutral06),
                    ),
                    const Spacer(),
                    Text(
                      kegiatanLiterasi.title!,
                      style: AppTextStyle.body2SemiBold,
                      maxLines: 2,
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
      ),
    );
  }
}
