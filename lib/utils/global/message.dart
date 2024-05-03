import 'package:fluttertoast/fluttertoast.dart';
import 'package:simarku/utils/global/app_colors.dart';

void successMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.greenSC03,
    textColor: AppColors.white,
    fontSize: 15,
  );
}

void errorMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.red,
    textColor: AppColors.white,
    fontSize: 15,
  );
}
