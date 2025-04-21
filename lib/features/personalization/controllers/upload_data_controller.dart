import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/banners/banners_repository.dart';
import 'package:pomme_dapi/data/repositories/brands/brands_repository.dart';
import 'package:pomme_dapi/data/repositories/categories/categories_repositories.dart';
import 'package:pomme_dapi/data/repositories/dummy_class.dart';
import 'package:pomme_dapi/data/repositories/products/product_repository.dart';
import 'package:pomme_dapi/data/repositories/relational/upload_relational.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instanse => Get.find();
  final _categoryRepository = Get.put(CategoryRepository());
  final _bannersRepository = Get.put(BannersRepository());
  final _productRepository = Get.put(ProductRepository());
  final _brandsRepository = Get.put(BrandsRepository());
  final _brandsCategoryProducts = Get.put(RelationalRepository());

  final isLoading = false.obs;

  /// Upload dummy categories data to Firebase
  Future<void> upLoadDummyCategories() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyCategories = AppDummyData.categories;

      // Upload dummy data to Firebase
      await _categoryRepository.uploadDummyData(dummyCategories);

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy categories uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> upLoadDummyBanners() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyBanners = AppDummyData.banners;

      // Upload dummy data to Firebase
      await _bannersRepository.uploadDummyData(dummyBanners);

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy Banners uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> upLoadDummyProducts() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyProducts = AppDummyData.products;

      // Upload dummy data to Firebase
      await _productRepository.uploadDummyData(dummyProducts);

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy Banners uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> upLoadDummyBrands() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyBrands = AppDummyData.brands;

      // Upload dummy data to Firebase
      await _brandsRepository.uploadDummyData(dummyBrands);

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy Brands uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> upLoadDummyBrandsCategory() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyBrandsCategoty = AppDummyData.brandCategories;

      // Upload dummy data to Firebase
      await _brandsCategoryProducts.uploadDummyBrandCategory(
        dummyBrandsCategoty,
      );

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy Brands Categories uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> upLoadDummyProductsCategory() async {
    try {
      // Show loader while uploading data
      isLoading.value = true;

      // Get dummy data from AppDummyData
      final dummyProductsCategoty = AppDummyData.productCategories;

      // Upload dummy data to Firebase
      await _brandsCategoryProducts.uploadDummyProductCategory(
        dummyProductsCategoty,
      );

      // Optionally, fetch the updated categories to reflect changes

      // Show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Dummy Product Categories uploaded successfully!",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
