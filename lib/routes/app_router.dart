// import 'package:get/get.dart';
// import 'package:simarku/features/activity/screen/activity_page.dart';
// import 'package:simarku/features/article/screen/all_article/screen/all_article_page.dart';
// import 'package:simarku/features/article/screen/detail_article/screen/detail_article_page.dart';
// import 'package:simarku/features/auth/forgot_password/fp_input_email/screen/fp_input_email_page.dart';
// import 'package:simarku/features/auth/forgot_password/fp_input_new_password/screen/fp_input_new_password_page.dart';
// import 'package:simarku/features/auth/login/screen/login_page.dart';
// import 'package:simarku/features/auth/otp_verification/screen/otp_verification_page.dart';
// import 'package:simarku/features/auth/register/screen/register_page.dart';
// import 'package:simarku/features/dashboard/screen/dashboard_page.dart';
// import 'package:simarku/features/dashboard/widgets/detail_book.dart';
// import 'package:simarku/features/dashboard/widgets/widgets.dart';
// import 'package:simarku/features/home/home_page.dart';
// import 'package:simarku/features/onboarding/screens/onboarding_page.dart';
// import 'package:simarku/features/profile/screen/edit_profile/screen/edit_profile_page.dart';
// import 'package:simarku/features/profile/screen/profile_page.dart';
// import 'package:simarku/features/search/screen/search_page.dart';
// import 'package:simarku/features/splash_screen/splash_screen.dart';

// class Routes {
//   // Splash Screen
// //   static const String splash = '/';

//   // Onboarding Screen
//   static const String onboarding = '/onboarding';

//   // Authentication
//   static const String login = '/login';
//   static const String register = '/register';
//   static const String otpVerification = '/otp_verification';
//   static const String fpInputEmail = '/forgot_password/input_email';
//   static const String fpInputNewPassword =
//       '/forgot_password/input_new_password';

//   // Home Page (Bottom Navigation)
//   static final String home = '/home';
//   static const String dashboard = '/dashboard';
//   static const String search = '/search';
//   static const String activity = '/activity';
//   static const String profile = '/profile';

//   // Dashboard Page
//   static const String article = '/article';
//   static const String detailArticle = '/detail_article';
//   static const String detailBook = '/detail_book';

//   // Profile Page
//   static const String editProfile = '/edit_profile';

//   static final routes = [
//     // Splash Screen
//     // GetPage(
//     //   name: splash,
//     //   page: () => SplashScreen(),
//     // ),

//     // Onboarding Page
//     GetPage(
//       name: onboarding,
//       page: () => OnboardingPage(),
//     ),

//     // Authentication
//     GetPage(
//       name: login,
//       page: () => LoginPage(),
//     ),
//     GetPage(
//       name: register,
//       page: () => RegisterPage(),
//     ),
//     GetPage(
//       name: otpVerification,
//       page: () => OTPVerificationPage(pageType: Get.arguments),
//     ),
//     GetPage(
//       name: fpInputEmail,
//       page: () => const FPInputEmailPage(),
//     ),
//     GetPage(
//       name: fpInputNewPassword,
//       page: () => const FPInputNewPasswordPage(),
//     ),

//     // Home Page (Bottom Navigation)
//     GetPage(
//       name: home,
//       page: () => HomePage(),
//     ),
//     GetPage(
//       name: dashboard,
//       page: () => DashboardPage(),
//     ),
//     GetPage(
//       name: search,
//       page: () => SearchPage(),
//     ),
//     GetPage(
//       name: activity,
//       page: () => ActivityPage(),
//     ),
//     GetPage(
//       name: profile,
//       page: () => const ProfilePage(),
//     ),

//     // Dashboard Page
//     GetPage(
//       name: article,
//       page: () => const AllArticlePage(),
//     ),
//     GetPage(
//       name: detailArticle,
//       page: () => DetailArticle(
//         article: Get.arguments,
//       ),
//     ),
//     GetPage(
//       name: detailBook,
//       page: () => DetailBook(
//         book: Get.arguments,
//       ),
//     ),

//     // Profile Page
//     GetPage(
//       name: editProfile,
//       page: () => const EditProfilePage(),
//     ),
//   ];
// }
