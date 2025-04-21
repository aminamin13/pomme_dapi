import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/features/shop/models/product_attribute_model.dart';
import 'package:pomme_dapi/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.description,
    this.categoryId,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    stock: 0,
    title: '',
    price: 0.0,
    thumbnail: '',
    productType: '',
  );

  toJson() {
    return {
      "Sku": sku,
      "Stock": stock,
      "Title": title,
      "Price": price,
      "Thumbnail": thumbnail,
      "ProductType": productType,
      "Brand": brand?.toJson(),
      "Date": date,
      "Images": images ?? [],
      "SalePrice": salePrice,
      "IsFeatured": isFeatured,
      "Description": description,
      "CategoryId": categoryId,
      "ProductAttributes":
          productAttributes != null
              ? productAttributes?.map((e) => e.toJson()).toList()
              : [],
      "ProductVariations":
          productVariations != null
              ? productVariations?.map((e) => e.toJson()).toList()
              : [],
    };
  }
 
  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['Sku'],
      title: data['Title'] ?? '',
      date: data['Date'] != null ? (data['Date'] as Timestamp).toDate() : null,
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes:
          (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList(),
      productVariations:
          (data['ProductVariations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList(),
    ); // Product Model
  }
  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['Sku'] ?? '',
      title: data['title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes:
          (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList(),
      productVariations:
          (data['Product Variations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList(),
    ); //ProductModel
  }
}
