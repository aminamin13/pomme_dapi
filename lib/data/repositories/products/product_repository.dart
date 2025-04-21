import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/services/storageServices/firebase_storage_service.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/exceptions/firebase_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot =
          await db
              .collection("Products")
              .where("IsFeatured", isEqualTo: true)
              .limit(4)
              .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot =
          await db
              .collection("Products")
              .where("IsFeatured", isEqualTo: true)
              .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await db.collection("Products").get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  // Future<List<ProductModel>> getProductsPaginated({
  //   required int limit,
  //   DocumentSnapshot? startAfter,
  // }) async {
  //   try {
  //     Query query = db.collection("Products").orderBy("Title").limit(limit);

  //     if (startAfter != null) {
  //       query = query.startAfterDocument(startAfter);
  //     }

  //     final snapshot = await query.get();

  //     return snapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
  //   } on FirebaseException catch (e) {
  //     throw AppFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw AppPlatformException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong. Please try again later.";
  //   }
  // }

  Future<List<ProductModel>> getProductForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final qureySnapshot =
          limit == -1
              ? await db
                  .collection("Products")
                  .where("Brand.Id", isEqualTo: brandId)
                  .get()
              : await db
                  .collection("Products")
                  .where("Brand.Id", isEqualTo: brandId)
                  .limit(limit)
                  .get();
      final products =
          qureySnapshot.docs
              .map((doc) => ProductModel.fromSnapshot(doc))
              .toList();
      return products;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot productCategoryQuery =
          limit == -1
              ? await db
                  .collection('ProductCategory')
                  .where('category_Id', isEqualTo: categoryId)
                  .get()
              : await db
                  .collection('ProductCategory')
                  .where('category_Id', isEqualTo: categoryId)
                  .limit(limit)
                  .get();
      // Extract productIds from the documents
      List<String> productIds =
          productCategoryQuery.docs
              .map((doc) => doc['product_Id'] as String)
              .toList();
      // Query to get all documents where the brand Id is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final productsQuery =
          await db
              .collection('Products')
              .where(FieldPath.documentId, whereIn: productIds)
              .get();
      // Extract brand names or other relevant data from the documents
      List<ProductModel> products =
          productsQuery.docs
              .map((doc) => ProductModel.fromSnapshot(doc))
              .toList();
      print("Products: ${products.length}");

      return products;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final qureySnapshot = await query.get();

      final List<ProductModel> productList =
          qureySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
    List<String> productIds,
  ) async {
    try {
      final snapshot =
          await db
              .collection("Products")
              .where(FieldPath.documentId, whereIn: productIds)
              .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(AppFirebaseStorageService());
      // Loop through each product
      for (var product in products) {
        // Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(
          product.thumbnail,
        );
        // Upload image and get its URL
        final url = await storage.uploadImageData(
          'Products/Images',
          thumbnail,
          product.thumbnail.toString(),
        );
        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;
        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);
            // Upload image and get its URL
            final url = await storage.uploadImageData(
              'Products/Images',
              assetImage,
              image,
            );
            // Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(
              variation.image,
            );
            // Upload image and get its URL
            final url = await storage.uploadImageData(
              'Products/Images',
              assetImage,
              variation.image,
            );
            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }
        // Store product in Firestore
        await db.collection("Products").doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
