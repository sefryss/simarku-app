import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utils/global/app_colors.dart';

class OTPVerificationInput extends StatefulWidget {
  const OTPVerificationInput({super.key});

  @override
  State<OTPVerificationInput> createState() => _OTPVerificationInputState();
}

class _OTPVerificationInputState extends State<OTPVerificationInput> {
  late StreamController<ErrorAnimationType> _controller;

  @override
  void initState() {
    _controller = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final items = [
    //   _inputOtpField(context, index: 0),
    //   const SizedBox(width: 4.0),
    //   _inputOtpField(context, index: 1),
    //   const SizedBox(width: 4.0),
    //   _inputOtpField(context, index: 2),
    //   const SizedBox(width: 4.0),
    //   _inputOtpField(context, index: 3),
    //   const SizedBox(width: 4.0),
    //   _inputOtpField(context, index: 4),
    //   const SizedBox(width: 4.0),
    //   _inputOtpField(context, index: 5),
    // ];
    // return Container();

    final fieldWidth =
        (MediaQuery.sizeOf(context).width - (16 * 2) - (12 * 5)) / 6;
    final fieldHeight = fieldWidth * 1.2;
    return PinCodeTextField(
      appContext: context,
      length: 6,
      scrollPadding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const SizedBox(
        width: 6,
      ),
      keyboardType: TextInputType.number,
      errorAnimationController: _controller,
      autoFocus: true,
      pinTheme: PinTheme(
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        selectedBorderWidth: 1,
        errorBorderWidth: 1,
        fieldWidth: fieldWidth,
        fieldHeight: fieldHeight,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.0),
        // activeColor:
        //     state.status.isSubmissionFailure && state.otp.value.length == 6
        //         ? AppColors.red
        //         : AppColors.green,
        inactiveColor: AppColors.neutral04,
        selectedColor: AppColors.neutral04,
        activeFillColor: AppColors.greenSC03,
        selectedFillColor: AppColors.greenSC03,
      ),
      // onChanged: (value) => context.read<OTPVerificationBloc>().add(
      //       OTPVerificationEvent.onOTPVerificationChangedEvent(
      //           value: value),
      //     ),
    );
  }
}

  // Widget _inputOtpField(BuildContext context, {required int index}) {
  //   return Expanded(
  //     child: TextField(
  //       decoration: const InputDecoration(
  //         filled: true,
  //         fillColor: Color(0xFFFFFBFE),
  //       ),
  //       onChanged: (value) {
  //         context.read<OTPVerificationBloc>().add(
  //             OTPVerificationEvent.onOTPVerificationChangedEvent(
  //                 value: value, index: index));
  //         if (value.length == 1) {
  //           FocusScope.of(context).nextFocus();
  //         } else if (value.isEmpty) {
  //           FocusScope.of(context).previousFocus();
  //         }
  //       },
  //       style: const TextStyle(
  //           color: AppColors.n2Black,
  //           fontWeight: FontWeight.w400,
  //           fontSize: 24.0),
  //       keyboardType: TextInputType.number,
  //       textAlign: TextAlign.center,
  //       inputFormatters: [
  //         LengthLimitingTextInputFormatter(1),
  //         FilteringTextInputFormatter.digitsOnly
  //       ],
  //     ),
  //   );
  // }
// }
