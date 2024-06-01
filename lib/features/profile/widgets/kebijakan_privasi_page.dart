import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class KebijakanPrivasiPage extends StatelessWidget {
  const KebijakanPrivasiPage({super.key});

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
          'Kebijakan Privasi',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dengan menginstal dan menggunakan Aplikasi SiMarKu, Anda dianggap telah menerima Ketentuan Layanan ini:',
                style: AppTextStyle.body2Regular,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '1. Akun Pengguna',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• Anda harus membuat akun untuk menggunakan aplikasi SiMarKu.
• Anda harus memberikan informasi yang benar dan akurat saat membuat akun.
• Anda bertanggung jawab untuk menjaga keamanan akun Anda dan semua aktivitas yang terjadi di akun Anda.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '2. Penggunaan Aplikasi',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• Anda tidak boleh menggunakan aplikasi SiMarKu untuk tujuan yang ilegal, menipu, atau berbahaya.
• Anda dilarang mengunggah atau mendistribusikan konten yang melanggar hak cipta, merek dagang, hak milik intelektual, berbahaya, menyinggung, atau diskriminatif.
• Anda tidak boleh menggunakan aplikasi SiMarKu untuk mengganggu atau melecehkan pengguna lain.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '3. Konten Pengguna',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• Anda bertanggung jawab atas semua konten yang Anda unggah ke aplikasi SiMarKu.
• Anda harus memastikan bahwa konten yang Anda unggah tidak melanggar Ketentuan Layanan ini.
• SiMarKu berhak untuk menghapus konten apa pun yang menurutnya tidak pantas atau melanggar Ketentuan Layanan ini.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '4. Privasi',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• SiMarKu berkomitmen untuk melindungi privasi Anda.
• Anda dapat membaca Kebijakan Privasi kami untuk informasi lebih lanjut tentang bagaimana kami mengumpulkan, menggunakan, dan mengungkapkan informasi Anda.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '5. Penafian dan Keterbatasan Tanggung Jawab',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• SiMarKu menyediakan aplikasi ini "sebagaimana adanya" dan tanpa jaminan apa pun, baik tersurat maupun tersirat.
• SiMarKu tidak bertanggung jawab atas kerusakan apa pun yang mungkin timbul dari penggunaan aplikasi ini.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '6. Perubahan Ketentuan Layanan',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• SiMarKu berhak untuk mengubah Ketentuan Layanan ini kapan saja.
• Jika kami mengubah Ketentuan Layanan ini, kami akan memberi tahu Anda melalui email atau pemberitahuan dalam aplikasi.
• Dengan terus menggunakan aplikasi ini setelah perubahan Ketentuan Layanan, Anda dianggap telah menerima perubahan tersebut.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '7. Seluruh Perjanjian',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• Ketentuan Layanan ini merupakan seluruh perjanjian antara Anda dan SiMarKu terkait dengan aplikasi ini.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                '8. Pemberitahuan',
                style: AppTextStyle.body1Medium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '''
• Semua pemberitahuan dan komunikasi lainnya terkait dengan Ketentuan Layanan ini akan dilakukan secara tertulis melalui email atau pemberitahuan dalam aplikasi.
''',
                style: AppTextStyle.body2Regular,
              ),
              Text(
                'Dengan menerima Ketentuan Layanan ini, Anda mengakui bahwa Anda telah membaca dan memahami semua ketentuan yang tercantum di sini.',
                style: AppTextStyle.body2Regular,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Terima kasih telah menggunakan SiMarKu!',
                style: AppTextStyle.body1Medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}