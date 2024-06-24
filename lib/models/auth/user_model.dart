import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String fullName;
  String nikNumber;
  String phoneNumber;
  String address;
  final String email;
  String profilePicture;
  bool isOnline;
  String lastActive;
  String pushToken;
  bool isAccess;
  bool isAdmin;
  String deviceId;

  UserModel({
    required this.id,
    required this.fullName,
    required this.nikNumber,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.profilePicture,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
    required this.isAccess,
    required this.isAdmin,
    required this.deviceId,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? nikNumber,
    String? phoneNumber,
    String? address,
    String? email,
    String? profilePicture,
    bool? isOnline,
    String? lastActive,
    String? pushToken,
    bool? isAccess,
    bool? isAdmin,
    String? deviceId,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nikNumber: nikNumber ?? this.nikNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      isOnline: isOnline ?? this.isOnline,
      lastActive: lastActive ?? this.lastActive,
      pushToken: pushToken ?? this.pushToken,
      isAccess: isAccess ?? this.isAccess,
      isAdmin: isAdmin ?? this.isAdmin,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        fullName: '',
        nikNumber: '',
        phoneNumber: '',
        address: '',
        email: '',
        profilePicture: '',
        isOnline: false,
        lastActive: '',
        pushToken: '',
        isAccess: false,
        isAdmin: false,
        deviceId: '',
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
      'IsOnline': isOnline,
      'LastActive': lastActive,
      'PushToken': pushToken,
      'IsAccess': isAccess,
      'IsAdmin': isAdmin,
      'DeviceId': deviceId,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
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
        isOnline: data['IsOnline'] ?? false,
        lastActive: data['LastActive'] ?? '',
        pushToken: data['PushToken'] ?? '',
        isAccess: data['IsAccess'] ?? false,
        isAdmin: data['IsAdmin'] ?? false,
        deviceId: data['DeviceId'] ?? '',
      );
    } else {
      // Handle the case where the document data is null
      // You can throw an exception, return an empty UserModel, etc.
      throw Exception("Document data is null!");
    }
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      id: doc.id,
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      fullName: data['FullName'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      nikNumber: data['NIKNumber'] ?? '',
      isOnline: data['IsOnline'] ?? false,
      lastActive: data['LastActive'] ?? '',
      pushToken: data['PushToken'] ?? '',
      isAccess: data['IsAccess'] ?? false,
      isAdmin: data['IsAdmin'] ?? false,
      deviceId: data['DeviceId'] ?? '',
    );
  }
}
