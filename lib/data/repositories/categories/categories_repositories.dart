import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/services/storageServices/firebase_storage_service.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/utils/exceptions/firebase_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }

  // Get Sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot =
          await _db
              .collection("Categories")
              .where("ParentId", isEqualTo: categoryId)
              .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    }
  }

  // upload Categories to firebase

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(AppFirebaseStorageService());

      //loop throw each category
      for (var category in categories) {
        // get image data link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // upload image and get url
        final url = await storage.uploadImageData(
          'Categories',
          file,
          category.image,
        );
        // assign url to category.name
        category.image = url;
        // store gategory in firebase
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    }
  }
}
