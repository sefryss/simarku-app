import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
 String fullName;
   String nikNumber;
   String phoneNumber;
   String address;
  final String email;
  String profilePicture;

  UserModel({
    required this.id,
    required this.fullName,
    required this.nikNumber,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.profilePicture,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? nikNumber,
    String? phoneNumber,
    String? address,
    String? email,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nikNumber: nikNumber ?? this.nikNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  /// Static function to create on empty user model
  static UserModel empty() => UserModel(
        id: '',
        fullName: '',
        nikNumber: '',
        phoneNumber: '',
        address: '',
        email: '',
        profilePicture: '',
      );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'NIKNumber': nikNumber,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'Email': email,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to crate a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!; // Use '!' for non-null assertion
      return UserModel(
        id: document.id,
        fullName: data['FullName'] ?? '',
        nikNumber: data['NIKNumber'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        address: data['Address'] ?? '',
        email: data['Email'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      // Handle the case where the document data is null
      // You can throw an exception, return an empty UserModel, etc.
      throw Exception("Document data is null!");
    }
  }
}
