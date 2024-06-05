import 'package:flutter/material.dart';
import 'package:simarku/features/donation_book/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class AddDonationBookPage extends StatelessWidget {
  const AddDonationBookPage({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: AppColors.primary,
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: DonationBookImageWidget(),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    DonationBookTitleWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    DonationBookTypeWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    DonationBookGenreWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DonationBookAuthorWidget(),
                        SizedBox(
                          width: 16.0,
                        ),
                        DonationBookPublisherWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DonationBookReleaseDateWidget(),
                        SizedBox(
                          width: 16,
                        ),
                        DonationBookPageWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    DonationBookOwnerWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    DonationBookDescWidget(),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: DonationSubmitBookButton(onTap: () {}),
      ),
    );
  }
}
