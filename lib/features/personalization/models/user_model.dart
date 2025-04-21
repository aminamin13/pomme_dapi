// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomme_dapi/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = "user",
    this.createdAt,
    this.updatedAt,
  });

  // helper methods
  String get fullName => '$firstName $lastName';
  String get formattedDate => AppFormater.formatDate(createdAt);
  String get formattedUpdatedDate => AppFormater.formatDate(updatedAt);
  String get formattedPhoneNo => AppFormater.formatPhoneNumber(phoneNumber);

  //create emoty user model
  static UserModel empty() => UserModel(email: '');

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  //convert model to json structure for storing in firebase

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }
  // factory method to create a usermodel from a firebase document snapshot

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture:
            data.containsKey('ProfilePicture')
                ? data['ProfilePicture'] ?? ''
                : '',
        role: data.containsKey('Role') ? data['Role'] ?? '' : '',

        createdAt:
            data.containsKey('CreatedAt')
                ? data['CreatedAt'].toDate() ?? DateTime.now()
                : DateTime.now(),
        updatedAt:
            data.containsKey('UpdatedAt')
                ? data['UpdatedAt'].toDate() ?? DateTime.now()
                : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
