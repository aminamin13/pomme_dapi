import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/brands/brands_repository.dart';
import 'package:pomme_dapi/data/repositories/products/product_repository.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class BrandsController extends GetxController {
  static BrandsController instance = Get.find();

  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  RxBool isLoading = true.obs;

  final _brandsRepository = Get.put(BrandsRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    // TODO: implement onInit
    super.onInit();
  }

  // load brands

  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await _brandsRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
        brands.where((brands) => brands.isFeatured ?? false).take(4),
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get Brands for Category

  Future<List<BrandModel>> getBrandsForCategory(categoryId) async {
    try {
      final brands = await _brandsRepository.getBrandsForCategory(categoryId);
       return brands;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }

  // Get Brand specifc product from your data source
  Future<List<ProductModel>> getBrandProducts({
    required brandId,
    int limit = -1,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductForBrand(
        brandId: brandId,
        limit: limit,
      );
      return products;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }
}
