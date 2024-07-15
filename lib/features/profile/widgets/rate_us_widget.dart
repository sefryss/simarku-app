import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/feedback/rate_us_controller.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/models/rate_us_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/shared_widgets/sm_elevated_button.dart';

Future<void> showRateUsDialog(BuildContext context, UserModel user) {
  final RateUsController rateUsController = Get.put(RateUsController());
  double rate = 5;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.neutral03,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Text("Waktunya Kasih Bintang",
                  style: AppTextStyle.heading5SemiBold),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "Seberapa puas sih kamu sama aplikasi SiMarKu?",
                  style: AppTextStyle.body2Regular,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              RatingBar(
                initialRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                glow: false,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset('assets/images/orange_star.svg'),
                  half: SvgPicture.asset('assets/images/star_half.svg'),
                  empty:
                      SvgPicture.asset('assets/images/rating_empty_star.svg'),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 10),
                onRatingUpdate: (rating) {
                  rate = rating;
                  print("Rate: $rating");
                },
              ),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: SMOutlineElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        labelText: 'Tidak',
                        backgroundColor: AppColors.neutral03,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SMElevatedButton(
                        onPressed: () {
                          // Collect feedback and add to controller
                          rateUsController.addFeedback(RateUsModel(
                            id: '', // Firestore will generate an ID
                            userId: user.id,
                            userName: user.fullName,
                            rating: rate,
                          ));
                          Navigator.of(context).pop();

                          // Show thank you dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                // backgroundColor: Colors.transparent,
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.neutral03,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                          height: 100,
                                          'assets/icons/icon_success.svg'),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text("Terima kasih sudah menilai kami!",
                                          style: AppTextStyle.heading5SemiBold,
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 20),
                                      Text(
                                          "Kami akan terus berusaha untuk memberikan pengalaman terbaik untuk Anda.",
                                          style: AppTextStyle.body2Regular,
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 20),
                                      SMElevatedButton(
                                        width: 120,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        labelText: 'Tutup',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        labelText: 'Ya',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      );
    },
  );
}
