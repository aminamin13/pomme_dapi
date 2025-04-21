import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/products/product_repository.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class SearchProductController extends GetxController {
  static SearchProductController get instance => Get.find();

  final RxList<ProductModel> products = <ProductModel>[].obs;

  RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final repository = ProductRepository.instance;

final RxString searchQuery = ''.obs;
// DocumentSnapshot? lastDocument;


void searchProducts(String query) {
  searchQuery.value = query; // track query state
  if (query.isEmpty) {
    searchResults.clear();
    return;
  }
  

  final lowerQuery = query.toLowerCase();

  final results = products.where(
    (product) =>
        product.title.toLowerCase().contains(lowerQuery) ||
        (product.brand?.name.toLowerCase().contains(lowerQuery) ?? false) ||
        (product.categoryId?.toLowerCase().contains(lowerQuery) ?? false),
  ).toList();

  searchResults.assignAll(results);
}


  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final fetchedProducts = await repository.getAllProducts();
      products.assignAll(fetchedProducts); // <-- populate the observable list
      return fetchedProducts;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }

//   Future<void> fetchNextProducts() async {
//   final newProducts = await repository.getProductsPaginated(
//     limit: 10,
//     startAfter: lastDocument,
//   );

//   if (newProducts.isNotEmpty) {
//     lastDocument = newProducts.last.; // make sure your ProductModel keeps the document snapshot or ref
//     products.addAll(newProducts);
//   }
// }
}
