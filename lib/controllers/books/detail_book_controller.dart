import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/pref_data.dart';

class DetailBookScreenController extends GetxController {
  int setindex = 0;
  RxBool like = false.obs;
  RxBool save = false.obs;

  RxList<String> favouriteList = <String>[].obs;
  RxList<String> bookMarkList = <String>[].obs;

  void getFavDataList() async {
    favouriteList.value = await PrefData.getFavouriteList();
  }

  void getBookMarkList() async {
    bookMarkList.value = await PrefData.getBookMarkList();
    // print("getvalsbook========${bookMarkList.length}");
  }

  checkInFav(String id) {
    like.value = favouriteList.contains(id);

    update();
  }

  checkInBookMark(String id) {
    // print("l-----------${save.value}");

    save.value = bookMarkList.contains(id);

    // print("lbook--------11---${save.value}");
    update();
  }

  checkInFavouriteList(StoryModel story) async {
    if (favouriteList.contains(story.id.toString())) {
      favouriteList.remove(story.id.toString());
      PrefData.setFavouriteList(favouriteList);
    } else {
      favouriteList.add(story.id!.toString());
      PrefData.setFavouriteList(favouriteList);
    }

    getFavDataList();
  }

  checkInBookMarkList(StoryModel story) async {
    if (bookMarkList.contains(story.id.toString())) {
      bookMarkList.remove(story.id.toString());
      PrefData.setBookMarkList(bookMarkList);
    } else {
      bookMarkList.add(story.id!.toString());
      PrefData.setBookMarkList(bookMarkList);
    }

    getFavDataList();
  }

  void onSetIndex(int index) {
    setindex = index;
    update();
  }
}

class AllReadBookController extends GetxController {
  RxList<DocumentSnapshot> filteredBookMarkList = <DocumentSnapshot>[].obs;

  checkDataExist(List<DocumentSnapshot> list, RxList<String> bookMarkList) {
    for (int i = 0; i < list.length; i++) {
      if (bookMarkList.contains(list[i].id)) {
        filteredBookMarkList.add(list[i]);
      }
    }
    update();
  }
}

class QuickReadController extends GetxController {
  RxList<DocumentSnapshot> filteredRecentList = <DocumentSnapshot>[].obs;

  void checkDataExist(List<DocumentSnapshot> list, RxList<String> recentList) {
    filteredRecentList.clear(); // Bersihkan list sebelum menambahkan data baru
    for (int i = 0; i < list.length; i++) {
      if (recentList.contains(list[i].id)) {
        filteredRecentList.add(list[i]);
      }
    }
    update();
  }
}

class RecentController extends GetxController {
  RxBool like = false.obs;
  RxBool save = false.obs;

  RxList<String> recentList = <String>[].obs; // Ubah menjadi RxList<String>

  void getRecentDataList() async {
    recentList.value = await PrefData.getRecentList();
  }

  void setRecentList(String id) {
    recentList.add(id);
    PrefData.setRecentList(recentList.toList()); // Ubah menjadi list untuk disimpan di SharedPreferences
  }
}
