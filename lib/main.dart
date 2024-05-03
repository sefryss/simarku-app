import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simarku/bindings/general_bindings.dart';
import 'package:simarku/features/onboarding/screens/onboarding_page.dart';
import 'package:simarku/features/splash_screen/splash_screen.dart';
import 'package:simarku/firebase_options.dart';
import 'package:simarku/utils/global/app_colors.dart';
import 'package:simarku/utils/global/app_theme.dart';
import 'package:simarku/repository/auth/auth_repository.dart';
import 'package:simarku/routes/app_router.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthRepository()));

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      //   home: SplashScreen(),
      home: const Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      //   getPages: Routes.routes,
    );
  }
}
