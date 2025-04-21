// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
  });
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  toJson() {
    return {
      "Id": id,
      "Name": name,
      "Image": image,
      "ProductsCount": productsCount,
      "IsFeatured": isFeatured,
      "CreatedAt": createdAt,
      "UpdatedAt": updatedAt,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      createdAt: data['CreatedAt'] ?? Timestamp.now(),
      updatedAt: data['UpdatedAt'] ?? Timestamp.now(),
    );
  }
  factory BrandModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return BrandModel(
      id: document.id,
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      createdAt: data['CreatedAt'] ?? Timestamp.now(),
      updatedAt: data['UpdatedAt'] ?? Timestamp.now(),
    );
  }
}
