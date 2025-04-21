import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/products/product_repository.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = "Name".obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

 

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchProductByQuery(query);
      return products;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }


  void sortProduct(String sortOption) {
    selectedSortOption.value = sortOption;

    List<ProductModel> sortedList = List.from(products);

    switch (sortOption) {
      case "Name":
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Highest Price":
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "Lowest Price":
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Most Recent":
        sortedList.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      case "Sale":
        sortedList.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        sortedList.sort((a, b) => a.title.compareTo(b.title));
    }

    // Update the products list
    products.assignAll(sortedList);
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProduct(
      selectedSortOption.value,
    ); // Sort based on initial selected option
  }
}
