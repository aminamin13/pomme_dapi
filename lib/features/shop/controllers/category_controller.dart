import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/categories/categories_repositories.dart';
import 'package:pomme_dapi/data/repositories/products/product_repository.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final _productRepostory = Get.put(ProductRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// load categories data
  Future<void> fetchCategories() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // Fetech categories from data source
      final categories = await _categoryRepository.getAllCategories();

      // update the categories list
      allCategories.assignAll(categories);
      // filter featured categories
      featureCategories.assignAll(
        allCategories
            .where((element) => element.isFeatured && element.parentId.isEmpty)
            .take(8)
            .toList(),
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// load selected category data
  ///
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategory = await _categoryRepository.getSubCategories(
        categoryId,
      );

      return subCategory;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Erdddddror", message: e.toString());
      return [];
    }
  }

  /// get category or subcategory products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId,
        limit: limit,
      );
      return products;
    } catch (e) {
      AppLoaders.warningSnackBar(
        title: "No Products Found",
        message: "This category has no products",
      );
      return [];
    }
  }
}
