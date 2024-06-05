import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/firbase_data/key_table.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/constant.dart';


class HomeController extends GetxController {
  StoryModel? storyModel = null;
  Genre? genreModel = null;
  SekilasInfoModel? sekilasInfoModel = null;
  KegiatanLiterasiModel? kegiatanLiterasiModel = null;
  UserModel? userModel = null;
  RxString slider = ''.obs;
  RxString author = ''.obs;
  RxString genre = ''.obs;
  RxString sekilasInfo = ''.obs;
  RxString kegiatanLiterasi = ''.obs;
  RxString user = ''.obs;
  RxString story = ''.obs;
  RxString storyNotification = ''.obs;
  RxString pdf = Constant.physichBook.obs;

  Rx<BookType> bookType = BookType.ebook.obs;
  Rx<Category> category = Category.bebasBaca.obs;

  RxList<String> allAuthorList = <String>[].obs;
  RxList<Genre> genreList = <Genre>[].obs;
  RxList<String> allGenreList = <String>[].obs;
  RxList<SekilasInfoModel> sekilasInfoList = <SekilasInfoModel>[].obs;
  RxList<KegiatanLiterasiModel> kegiatanLiterasiList =
      <KegiatanLiterasiModel>[].obs;
  RxList<String> allSekilasInfoList = <String>[].obs;
  RxList<String> allKegiatanLiterasiList = <String>[].obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<String> allUserList = <String>[].obs;
  RxList<StoryModel> storyList = <StoryModel>[].obs;
  RxList<StoryModel> storyListNotification = <StoryModel>[].obs;
  RxList<String> sliderList = <String>[].obs;
  RxList<String> allStoryList = <String>[].obs;
  RxList<String> allStoryListNotification = <String>[].obs;
  RxList<String> sliderIdList = <String>[].obs;
  RxBool isLoading = false.obs;

  List<String> pdfOptionList = [Constant.physichBook, Constant.file];
  List<Category> categoryList = Category.values;
  List<BookType> bookTypeList = BookType.values;

  @override
  void onInit() {
    super.onInit();
    fetchStoryData();
    fetchGenreData();
    fetchSekilasInfoData();
    fetchKegiatanLiterasiData();
    fetchUserData();
    fetchStoryDataForNotification();
  }


  fetchStoryData() async {
    isLoading(true);
    storyList.clear();
    allStoryList.clear();
    story("");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(KeyTable.storyList).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      for (var doc in list1) {
        var story = StoryModel.fromFirestore(doc);
        storyList.add(story);
        allStoryList.add(story.name!);
      }
      isLoading(false);
      story((list1[0]).id);
    } else {
      isLoading(false);
    }
  }

  fetchStoryDataForNotification() async {
    isLoading(true);
    storyListNotification.clear();
    allStoryListNotification.clear();
    storyNotification("");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(KeyTable.storyList).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      for (var doc in list1) {
        var story = StoryModel.fromFirestore(doc);
        storyListNotification.add(story);
        allStoryListNotification.add(story.name!);
      }
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  fetchGenreData() async {
    isLoading(true);
    genreList.clear();
    allGenreList.clear();
    genre("");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(KeyTable.genreList).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      for (var doc in list1) {
        var genre = Genre.fromFirestore(doc);
        genreList.add(genre);
        allGenreList.add(genre.genre!);
      }
      isLoading(false);
      genre((list1[0]).id);
    } else {
      isLoading(false);
    }
  }

  fetchSekilasInfoData() async {
    isLoading(true);
    sekilasInfoList.clear();
    allSekilasInfoList.clear();
    sekilasInfo("");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(KeyTable.sekilasInfo).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      for (var doc in list1) {
        var sekilasInfo = SekilasInfoModel.fromFirestore(doc);
        sekilasInfoList.add(sekilasInfo);
        allSekilasInfoList.add(sekilasInfo.title!);
      }
      isLoading(false);
      sekilasInfo((list1[0]).id);
    } else {
      isLoading(false);
    }
  }

  fetchKegiatanLiterasiData() async {
    isLoading(true);
    kegiatanLiterasiList.clear();
    allKegiatanLiterasiList.clear();
    kegiatanLiterasi("");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.kegiatanLiterasi)
        .get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      for (var doc in list1) {
        var kegiatanLiterasi = KegiatanLiterasiModel.fromFirestore(doc);
        kegiatanLiterasiList.add(kegiatanLiterasi);
        allKegiatanLiterasiList.add(kegiatanLiterasi.title!);
      }
      isLoading(false);
      kegiatanLiterasi((list1[0]).id);
    } else {
      isLoading(false);
    }
  }

  Future<List<UserModel>> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users') // Assuming the collection is named 'Users'
          .get();

      List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc);
      }).toList();

      return users;
    } catch (e) {
      print('Error fetching user data: $e');
      return [];
    }
  }
}
