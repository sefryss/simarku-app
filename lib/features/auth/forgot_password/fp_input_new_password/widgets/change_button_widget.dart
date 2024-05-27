import 'package:flutter/material.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class ChangeButton extends StatelessWidget {
  const ChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SMElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AuthSuccessDialog(
                onPressed: () {
                //   Get.toNamed(Routes.login);
                },
                title: 'Kata Sandi Berhasil Diubah',
                body: 'Silahkan masuk kembali',
                buttonText: 'Masuk Kembali'),
          );
        },
        labelText: 'Kirim');
  }
}
