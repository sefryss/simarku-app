import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/kegiatan_literasi/widgets/detail_kegiatan_literasi.dart';
import 'package:simarku/features/kegiatan_literasi/widgets/kegiatan_literasi_card.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AllKegiatanLiterasi extends StatelessWidget {
  const AllKegiatanLiterasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Kegiatan Literasi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseData.getKegiatanLiterasiList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<KegiatanLiterasiModel> kegiatanLiterasiList = snapshot
                        .data!.docs
                        .map((doc) => KegiatanLiterasiModel.fromFirestore(doc))
                        .toList();

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(
                                () => DetailKegiatanLiterasi(
                                  kegiatanLiterasi: kegiatanLiterasiList[index],
                                ),
                              );
                            },
                            child: KegiatanLiterasiCard(
                                kegiatanLiterasi: kegiatanLiterasiList[index]));
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 0),
                      itemCount: kegiatanLiterasiList.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
