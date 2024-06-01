import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/pref_data.dart';

class SekilasInfoController extends GetxController {
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

  checkInFavouriteList(SekilasInfoModel article) async {
    if (favouriteList.contains(article.id.toString())) {
      favouriteList.remove(article.id.toString());
      PrefData.setFavouriteList(favouriteList);
    } else {
      favouriteList.add(article.id!.toString());
      PrefData.setFavouriteList(favouriteList);
    }

    getFavDataList();
  }

  checkInBookMarkList(SekilasInfoModel article) async {
    if (bookMarkList.contains(article.id.toString())) {
      bookMarkList.remove(article.id.toString());
      PrefData.setBookMarkList(bookMarkList);
    } else {
      bookMarkList.add(article.id!.toString());
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