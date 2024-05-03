import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'dart:async';

class ResendingOTP extends StatefulWidget {
  const ResendingOTP({Key? key}) : super(key: key);

  @override
  _ResendingOTPState createState() => _ResendingOTPState();
}

class _ResendingOTPState extends State<ResendingOTP> {
  int _countdown = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel(); // Menghentikan timer saat countdown mencapai 0
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tidak Menerima Kode OTP ?',
          textAlign: TextAlign.center,
          style: AppTextStyle.body2Regular.copyWith(color: AppColors.neutral06),
        ),
        const SizedBox(
          height: 4,
        ),
        _countdown > 0
            ? Text(
                'Kirim ulang dalam $_countdown detik',
                textAlign: TextAlign.center,
                style:
                    AppTextStyle.body2Medium.copyWith(color: AppColors.primary),
              )
            : Text(
                'Kirim Kode OTP',
                textAlign: TextAlign.center,
                style:
                    AppTextStyle.body2Medium.copyWith(color: AppColors.primary),
              ),
      ],
    );
  }
}
