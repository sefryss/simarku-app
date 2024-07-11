import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/feedback/feedback_controller.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class FeedbackPage extends StatelessWidget {
  final UserModel user; // Pass user information to FeedbackPage

  const FeedbackPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final FeedbackController feedbackController = Get.put(FeedbackController());
    final TextEditingController feedbackControllerText =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Umpan Balik',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Berikan kami umpan balik',
                  style: AppTextStyle.heading4SemiBold),
              SizedBox(height: 8),
              Text('Pendapat kamu sangat berguna bagi kami!',
                  style: AppTextStyle.body2Regular),
              SizedBox(height: 24),
              Text('Apa yang kamu suka tentang aplikasi ini?',
                  style: AppTextStyle.body2SemiBold),
              SizedBox(height: 10),
              TextFormField(
                controller: feedbackControllerText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: AppColors.neutral03, width: 1)),
                  hintText: 'Tulis umpan balik kamu...',
                  hintStyle: AppTextStyle.body2Regular
                      .copyWith(color: AppColors.neutral05),
                ),
                maxLines: 14,
              ),
              SizedBox(height: 24),
              SMElevatedButton(
                width: double.infinity,
                onPressed: () {
                  if (feedbackControllerText.text.isEmpty) {
                    SMLoaders.errorSnackBar(
                      title: 'Oops',
                      message: 'Umpan balik belum kamu isi.',
                    );
                  } else {
                    // Add feedback
                    feedbackController.addFeedback(FeedbackModel(
                      id: '', // Firestore will generate an ID
                      userId: user.id,
                      userName: user.fullName,
                      feedback: feedbackControllerText.text,
                    ));
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          // backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.symmetric(horizontal: 20),
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
                                Text("Terima kasih sudah memberikan pendapat!",
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
                  }
                },
                labelText: 'Kirim',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
