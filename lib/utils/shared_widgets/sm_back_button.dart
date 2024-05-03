import 'package:flutter/material.dart';

class SMBackButton extends StatelessWidget {
  const SMBackButton({
    super.key,
    this.buttonColor,
  });

  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.centerLeft,
      onPressed: () {
        Navigator.pop(context);
      },
      padding: const EdgeInsets.all(16),
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: buttonColor ?? Color(0xFFFFFBFE),
      ),
    );
  }
}
