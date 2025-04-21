// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BannersModel {
  String targetScreen;
  bool active;
  String imageUrl;
  String id;
  BannersModel({
    required this.id,
    required this.targetScreen,
    required this.active,
    required this.imageUrl,
  });

  // empty helper function
  static BannersModel empty() => BannersModel(
        id: '',
        targetScreen: '',
        imageUrl: '',
        active: false,
      );
  // convert model to json so that you can store data in firebase

  Map<String, dynamic> toJson() => {
        'ImageUrl': imageUrl,
        'Active': active,
        'TargetScreen': targetScreen,
      };

  //Map json oriented document snapshot from friebase to user model
  factory BannersModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return BannersModel(
      id: document.id,
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}
