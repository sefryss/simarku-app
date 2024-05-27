import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class TukarMilikBookView extends StatelessWidget {
  const TukarMilikBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          'Tukar Milik ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}