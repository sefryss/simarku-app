import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/controllers/firbase_data/key_table.dart';
import 'package:simarku/features/activity/widgets/my_book.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/constant.dart';
import 'package:simarku/utils/constantWidget.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/full_screen_loader.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/network/network_manager.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class BookController extends GetxController {
  static BookController get instance => Get.find();

  // Variables
  List<BookType> bookTypeList = BookType.values;
  RxString pdf = Constant.file.obs;
  RxString genre = ''.obs;
  Rx<BookType> bookType = BookType.physicalBook.obs;
  Rx<Category> category = Category.bebasBaca.obs;
  RxList<Genre> genreList = <Genre>[].obs;
  RxList<String> allGenreList = <String>[].obs;

  GlobalKey<FormState> bookFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController pdfController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController pageController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController releaseDateController = TextEditingController();
  TextEditingController bookTypeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descController = TextEditingController();
  RxString pdfUrl = ''.obs;
  RxString pdfSize = ''.obs;
  Uint8List webImage = Uint8List(10);
  Uint8List webFile = Uint8List(10);
  RxBool isImageOffline = false.obs;

  StoryModel? storyModel;
  RxBool isLoading = false.obs;
  RxBool isPopular = false.obs;
  RxBool isFeatured = false.obs;
  RxBool isAvailable = true.obs;
  String oldGenre = '';

  RxList selectedGenre = [].obs;
  RxList selectedGenreNameList = [].obs;
  RxList selectedCategory = [].obs;
  RxList selectedCategoryNameList = [].obs;
  RxList selectedUser = [].obs;
  RxList selectedUserNameList = [].obs;

  XFile? pickImage;
  final picker = ImagePicker();
  FilePickerResult? result;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchGenreData();
    setAllDataFromStoryModel(storyModel);
  }

  // Fetch Genre Data
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

  getGenre(List selectedList) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(KeyTable.genreList).get();
    if (snapshot.docs.isNotEmpty && snapshot.size > 0) {
      List<DocumentSnapshot> list = snapshot.docs;
      for (int i = 0; i < list.length; i++) {
        if (selectedList.contains(list[i].id)) {
          selectedGenreNameList.add(Genre.fromFirestore(list[i]).genre!);
        }
      }
    }
    genreController.text = selectedGenreNameList
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');
  }

  getUser(List selectedList) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(KeyTable.user).get();
    if (snapshot.docs.isNotEmpty && snapshot.size > 0) {
      List<DocumentSnapshot> list = snapshot.docs;
      for (int i = 0; i < list.length; i++) {
        if (selectedList.contains(list[i].id)) {
          selectedUser.add(list[i].id);
          selectedUserNameList.add(UserModel.fromFirestore(list[i]).fullName);
        }
      }
    }
    ownerController.text =
        selectedUserNameList.toString().replaceAll('[', '').replaceAll(']', '');
  }

  setAllDataFromStoryModel(StoryModel? s) {
    if (s != null) {
      storyModel = s;
      if (storyModel != null) {
        getGenre(storyModel!.genreId!);
        getUser(storyModel!.ownerId!);

        String fileName = storyModel!.image!.split('%2F').last;
        String file = fileName.split('?').first;

        String pdfFileName = storyModel!.pdf!.split('%2F').last;
        String pdfFile = pdfFileName.split('?').first;

        if (storyModel!.pdf!.contains("firebase")) {
          pdf.value = Constant.file;
        }

        oldGenre = '';
        nameController.text = storyModel!.name!;
        authorController.text = storyModel!.author!;
        pageController.text = storyModel!.page!;
        publisherController.text = storyModel!.publisher!;
        releaseDateController.text = storyModel!.releaseDate!;
        imageController.text = file;
        selectedGenre.value = storyModel!.genreId!;

        genre.value = storyModel!.refId!;
        category.value = storyModel!.category!;
        bookType.value = storyModel!.bookType!;

        pdfUrl.value = pdfFile;
        descController.text = storyModel!.desc!;

        oldGenre = nameController.text;

        isPopular.value = storyModel!.isPopular!;
        isFeatured.value = storyModel!.isFeatured!;
        isAvailable.value = storyModel!.isAvailable!;
      }
    }
  }

  // Clear Data
  clearStoryData() {
    nameController.clear();
    authorController.clear();
    pageController.clear();
    publisherController.clear();
    releaseDateController.clear();
    bookTypeController.clear();
    categoryController.clear();
    imageController.clear();
    pdfController.clear();
    descController.clear();
    pdfUrl.value = '';
    pdfSize.value = '';
    webImage = Uint8List(10);
    genreController.clear();
    ownerController.clear();
    selectedGenre.clear();
    selectedGenreNameList.clear();
    selectedUser.clear();
    selectedUserNameList.clear();
    selectedCategory.clear();
    selectedCategoryNameList.clear();
    webFile = Uint8List(10);
    isImageOffline.value = false;
    storyModel = null;
    isLoading.value = false;
    isPopular.value = false;
    isFeatured.value = false;
    isAvailable.value = false;
    oldGenre = '';
  }

  // Add Story
  Future<void> addStory() async {
    try {
      SMFullScreenLoader.openLoadingDialog('assets/animations/loading.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      if (!bookFormKey.currentState!.validate()) {
        SMFullScreenLoader.stopLoading();
        return;
      }

      String url = pickImage != null ? await uploadFile(pickImage!) : '';
      String pdfUploadUrl = await uploadPdfFile();

      // Log PDF URL
      print('PDF Upload URL: $pdfUploadUrl');

      StoryModel firebaseHistory = StoryModel(
        name: nameController.text,
        author: authorController.text,
        publisher: publisherController.text,
        releaseDate: releaseDateController.text,
        page: pageController.text,
        image: url,
        pdf: (pdf.value == Constant.physichBook)
            ? pdfController.text
            : pdfUploadUrl,
        refId: genre.value,
        genreId: selectedGenre,
        index: await FireBaseData.getLastIndexFromGenreTable(),
        ownerId: selectedUser,
        desc: descController.text,
        isActive: true,
        views: 0,
        isBookmark: false,
        isFav: false,
        isPopular: isPopular.value,
        isFeatured: isFeatured.value,
        isAvailable: isAvailable.value,
        bookType: bookType.value,
        category: category.value,
      );

      Map<String, dynamic> data = firebaseHistory.toJson();
      await FirebaseFirestore.instance.collection(KeyTable.storyList).add(data);

      SMFullScreenLoader.stopLoading();
      clearStoryData();
      SMLoaders.successSnackBar(
          title: 'Selamat', message: 'Buku berhasil ditambahkan');
      print("Story added successfully");
      Get.off(() => MyBook());
    } catch (e) {
      SMFullScreenLoader.stopLoading();
      print('Error adding story: $e');
      showCustomToast(
          message: 'Failed to add story. Please try again.', title: 'Error');
    }
  }

  // Upload File
  Future<String> uploadFile(XFile _image) async {
    try {
      final fileBytes = await _image.readAsBytes();
      var reference =
          FirebaseStorage.instance.ref().child("files/${_image.name}");

      UploadTask uploadTask = reference.putData(
          fileBytes,
          SettableMetadata(
              contentType:
                  "image/${getFileExtension(_image.name).replaceAll('.', '')}"));

      return await getUrlFromTask(uploadTask);
    } catch (e) {
      print('Error in uploading image: ${e.toString()}');
      return '';
    }
  }

// Upload PDF File
// Upload PDF File
  Future<String> uploadPdfFile() async {
    try {
      if (result == null || result!.files.isEmpty) {
        print("No file selected for upload");
        return '';
      }

      Uint8List? fileBytes = result!.files.first.bytes;
      if (fileBytes == null && result!.files.first.path != null) {
        File file = File(result!.files.first.path!);
        fileBytes = await file.readAsBytes();
      }

      if (fileBytes == null) {
        print("File bytes are null");
        throw Exception("File bytes are null");
      }

      String fileName = result!.files.first.name;
      var reference = FirebaseStorage.instance.ref().child('uploads/$fileName');

      UploadTask uploadTask = reference.putData(
        fileBytes,
        SettableMetadata(contentType: "application/pdf"),
      );

      return await getUrlFromTask(uploadTask);
    } catch (e) {
      print('Error in uploading PDF: ${e.toString()}');
      return '';
    }
  }

  // Get URL from Task
  Future<String> getUrlFromTask(UploadTask uploadTask) async {
    try {
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        print("Upload complete");
      }).catchError((error) {
        print("Error during upload: $error");
      });

      String url = await taskSnapshot.ref.getDownloadURL();
      print("File URL: $url");

      return url;
    } catch (e) {
      print("Error getting download URL: $e");
      return '';
    }
  }

  // Get File Extension
  String getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch (e) {
      return '';
    }
  }

  // Open File Picker
  openFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result!.files.isNotEmpty) {
        String fileName = result!.files.first.name;
        String size =
            getFileSizeString(bytes: result!.files.first.size, decimals: 1);

        // Read file bytes manually if result!.files.first.bytes is null
        Uint8List? fileBytes = result!.files.first.bytes;
        if (fileBytes == null && result!.files.first.path != null) {
          File file = File(result!.files.first.path!);
          fileBytes = await file.readAsBytes();
        }

        if (fileBytes != null) {
          webFile = fileBytes; // Assign to webFile
          pdfUrl.value = fileName;
          pdfSize.value = size;
          print("File picked: $fileName, Size: $size");
        } else {
          print("File bytes are null");
        }
      } else {
        pdfUrl.value = '';
        print("No file picked");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  // Get File Size String
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  bool isSvg = false;

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    pickImage = image;

    if (image != null) {
      String file = image.name.split(".").last;

      if (file == "svg") {
        isSvg = true;
      }
      imageController.text = pickImage!.name;
      var f = await pickImage!.readAsBytes();
      isImageOffline(false);
      webImage = f;
      isImageOffline(true);
    }
  }

  Future<void> showGenreDialog(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          print("genreList------_${genreList.length}");
          return AlertDialog(
            title: Text(
              'Pilih Genre',
              style: AppTextStyle.body2Medium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // backgroundColor: getBackgroundColor(context),
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: genreList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // title: getCustomFont("text", 18, getFontColor(context), 1),
                    title: Text(
                      genreList[index].genre!,
                      style: AppTextStyle.body3Regular,
                    ),
                    trailing: Obx(() => Checkbox(
                        activeColor: AppColors.primary,
                        checkColor: Colors.white,
                        onChanged: (checked) {
                          print(
                              "checked--------${selectedGenre.contains(genreList[index].id!)}--------${checked}");

                          if (selectedGenre.contains(genreList[index].id!)) {
                            selectedGenre.remove(genreList[index].id!);
                            selectedGenreNameList
                                .remove(genreList[index].genre!);
                          } else {
                            selectedGenre.add(genreList[index].id!);
                            selectedGenreNameList.add(genreList[index].genre!);
                          }

                          print("selecteLen--------${selectedGenre.length}");

                          // isChecked[index] = checked;
                          // _title = _getTitle();
                        },
                        value: selectedGenre.contains(genreList[index].id!))),
                  );
                },
              ),
            ),
            actions: [
              SMElevatedButton(
                  onPressed: () {
                    Get.back();
                    genreController.text = selectedGenreNameList
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '');
                  },
                  labelText: 'Pilih'),
            ],
          );
        });
  }

  Future<void> showOwnerDialog(BuildContext context) async {
    List<UserModel> userList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      userList = querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching user data: $e');
    }

    if (userList.isEmpty) {
      showCustomToast(message: "No Data");
      return;
    }

    RxString selectedOwnerId = ''.obs;
    RxString selectedOwnerName = ''.obs;

    if (selectedUser.isNotEmpty) {
      selectedOwnerId.value = selectedUser.first;
      selectedOwnerName.value = selectedUserNameList.first;
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Pilih Pemilik',
            style: AppTextStyle.body2Medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.neutral02,
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    userList[index].fullName,
                    style: AppTextStyle.body3Regular,
                  ),
                  trailing: Obx(() => Radio<String>(
                        activeColor: AppColors.primary,
                        value: userList[index].id,
                        groupValue: selectedOwnerId.value,
                        onChanged: (String? value) {
                          if (value != null) {
                            selectedOwnerId.value = value;
                            selectedOwnerName.value = userList[index].fullName;
                          }
                        },
                      )),
                );
              },
            ),
          ),
          actions: [
            SMElevatedButton(
                onPressed: () {
                  if (selectedOwnerId.isNotEmpty) {
                    selectedUser.clear();
                    selectedUser.add(selectedOwnerId.value);
                    selectedUserNameList.clear();
                    selectedUserNameList.add(selectedOwnerName.value);
                    ownerController.text = selectedOwnerName.value;
                    Get.back();
                  } else {
                    showCustomToast(
                      message: 'Pilih pemilik...',
                      title: 'Error',
                    );
                  }
                },
                labelText: 'Pilih')
          ],
        );
      },
    );
  }
}
