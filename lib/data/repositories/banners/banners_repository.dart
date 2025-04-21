import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/services/storageServices/firebase_storage_service.dart';
import 'package:pomme_dapi/features/shop/models/banners_model.dart';
import 'package:pomme_dapi/utils/exceptions/firebase_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/platform_exceptions.dart';

class BannersRepository extends GetxController {
  static BannersRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all Categories
  Future<List<BannersModel>> getAllBanners() async {
    try {
      final result =
          await _db
              .collection('Banners')
              .where('Active', isEqualTo: true)
              .get();
      return result.docs.map((e) => BannersModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later.";
    }
  }
  // upload Categories to firebase

  Future<void> uploadDummyData(List<BannersModel> banners) async {
    try {
      final storage = Get.put(AppFirebaseStorageService());

      //loop throw each category
      for (var banner in banners) {
        // get image data link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // upload image and get url
        final url = await storage.uploadImageData(
          'Banners',
          file,
          banner.imageUrl,
        );
        // assign url to category.name
        banner.imageUrl = url;
        // store gategory in firebase
        await _db.collection('Banners').doc(banner.id).set(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    }
  }
}
