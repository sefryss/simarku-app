import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/features/donation_book/widgets/donation_book_card.dart';
import 'package:simarku/features/donation_book/widgets/donation_book_detail.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class DonationBookPage extends StatelessWidget {
  const DonationBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Donasi Buku',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          16.0,
          24.0,
          0,
          16.0,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FireBaseData.getDonationBookList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<DonationBookModel> bookList = snapshot.data!.docs.map((doc) {
              return DonationBookModel.fromFirestore(doc);
            }).toList();

            List<DonationBookModel> filteredBookList = bookList.toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.5,
              ),
              itemCount: filteredBookList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.to(
                    () => DonationDetailBook(book: filteredBookList[index]),
                  ),
                  child: DonationBookCard(
                    book: filteredBookList[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
