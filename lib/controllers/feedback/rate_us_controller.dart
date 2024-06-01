import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/models/models.dart';

class RateUsController extends GetxController {
  var ratingList = <RateUsModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addFeedback(RateUsModel rating) async {
    try {
      await firestore.collection('rating').add(rating.toJson());
      ratingList.add(rating);
    } catch (e) {
      print("Error adding rating: $e");
    }
  }

  void fetchratings() async {
    try {
      var result = await firestore.collection('rating').get();
      ratingList.value =
          result.docs.map((doc) => RateUsModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching rating: $e");
    }
  }
}
