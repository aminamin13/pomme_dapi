import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/features/shop/models/brand_category_model.dart';
import 'package:pomme_dapi/features/shop/models/product_category_model.dart';

class RelationalRepository extends GetxController {
  static RelationalRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  Future<void> uploadDummyBrandCategory(
    List<BrandCategoryModel> brandCategories,
  ) async {
    try {
      // Loop through each brand-category association
      for (var brandCategory in brandCategories) {
        // Store each brand-category association in Firestore
        await db.collection('BrandCategory').add(brandCategory.toJson());
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

  Future<void> uploadDummyProductCategory(
    List<ProductCategoryModel> productCategories,
  ) async {
    try {
      // Loop through each brand-category association
      for (var productCategory in productCategories) {
        // Store each brand-category association in Firestore
        await db.collection('ProductCategory').add(productCategory.toJson());
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
