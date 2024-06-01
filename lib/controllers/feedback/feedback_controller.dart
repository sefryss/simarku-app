import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/models/models.dart';

class FeedbackController extends GetxController {
  var feedbackList = <FeedbackModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addFeedback(FeedbackModel feedback) async {
    try {
      await firestore.collection('feedback').add(feedback.toJson());
      feedbackList.add(feedback);
    } catch (e) {
      print("Error adding feedback: $e");
    }
  }

  void fetchFeedbacks() async {
    try {
      var result = await firestore.collection('feedback').get();
      feedbackList.value = result.docs
          .map((doc) => FeedbackModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print("Error fetching feedbacks: $e");
    }
  }
}
