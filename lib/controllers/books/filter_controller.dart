import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxMap selectedItems = {}.obs;

  void updateSelectedItems(String key, dynamic value) {
    if (value != null) {
      selectedItems[key] = value;
    } else {
      selectedItems.remove(key);
    }
  }

  // Buat fungsi untuk menutup bottom sheet
  void closeBottomSheet() {
    Get.back();
  }
}
