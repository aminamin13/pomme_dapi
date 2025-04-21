import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/features/personalization/models/settings_model.dart';
import 'package:pomme_dapi/utils/exceptions/firebase_exceptions.dart';
import 'package:pomme_dapi/utils/exceptions/platform_exceptions.dart';
 

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> registerSettings(SettingsModel settings) async {
    try {
      await _db
          .collection("Settings")
          .doc("GLOBAL_SETTINGS")
          .set(settings.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<SettingsModel> getSettings() async {
    try {
      final snapshot =
          await _db.collection("Settings").doc("GLOBAL_SETTINGS").get();
      return SettingsModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
 
}
