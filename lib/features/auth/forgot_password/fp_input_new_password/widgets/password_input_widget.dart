import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SMTextField(
      labelText: 'Kata Sandi',
      labelColor: AppColors.neutralBlack,
      hintText: 'Masukkan Kata Sandi',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabledBorderColor: AppColors.neutral04,
      onChanged: (email) => {},
      // errorText: 'Email pengguna tidak boleh kosong',
    );
  }
}
