import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simarku/utils/global/app_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // empty text to make center image
              Text(
                '',
                style: AppTextStyle.body2Regular,
              ),

              // kg logo
              Center(
                child: SvgPicture.asset(
                  'assets/images/icon_simarku.svg',
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),

              // app version
              Text(
                '',
                textAlign: TextAlign.center,
                style: AppTextStyle.body2Regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
