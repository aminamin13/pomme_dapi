// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomme_dapi/utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  String parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => AppFormater.formatDate(createdAt);
  String get formattedUpdateDate => AppFormater.formatDate(updatedAt);

  // empty helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  // convert model to json so that you can store data in firebase

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Image': image,
    'isFeatured': isFeatured,
    'ParentId': parentId,
    'CreatedAt': createdAt,
    'UpdatedAt': updatedAt = DateTime.now(),
  };

  //Map json oriented document snapshot from friebase to user model
  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
