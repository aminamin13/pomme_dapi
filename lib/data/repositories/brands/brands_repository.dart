import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/services/storageServices/firebase_storage_service.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/utils/exceptions/firebase_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/format_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/platform_exceptions.dart';

class BrandsRepository extends GetxController {
  static BrandsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all Categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final result = await _db.collection('Brands').get();
      return result.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final result =
          await _db
              .collection('Brands')
              .where('IsFeatured', isEqualTo: true)
              .get();
      return result.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandsCategoryQuery =
          await _db.collection("BrandCategory").get();

      List<String> brandsId =
          brandsCategoryQuery.docs
              .map((doc) => doc['brandId'] as String)
              .toList();
      print("Brands count: ${brandsId.length}");

      final brandsQuery =
          await _db
              .collection("Brands")
              .where(FieldPath.documentId, whereIn: brandsId)
              .limit(2)
              .get();
      print("Brands found: ${brandsQuery.docs.length}");

      return brandsQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  // upload Categories to firebase

  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage = Get.put(AppFirebaseStorageService());

      //loop throw each category
      for (var brand in brands) {
        // get image data link from the local assets
        final file = await storage.getImageDataFromAssets(brand.image);

        // upload image and get url
        final url = await storage.uploadImageData('Brands', file, brand.image);
        // assign url to category.name
        brand.image = url;
        // store gategory in firebase
        await _db.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    }
  }
}
