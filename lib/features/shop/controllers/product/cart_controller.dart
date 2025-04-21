import 'package:get/get.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_variation_controller.dart';
import 'package:pomme_dapi/features/shop/models/cart_item_model.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = Get.put(ProductVariationController());

  CartController() {
    loadCartItems();
  }

  // add items to cart
  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      AppLoaders.customToast(message: "Select a quantity");
      return;
    }
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      AppLoaders.customToast(message: "Select a variation");
      return;
    }
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        AppLoaders.warningSnackBar(
          message: "Selected Variaition is out of Stock",
          title: "Oh Snap!",
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        AppLoaders.warningSnackBar(
          message: "Selected Product is out of Stock",
          title: "Oh Snap!",
        );
        return;
      }
    }
    
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    AppLoaders.customToast(message: "Product added to cart");
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Show dialog before completely removing
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Item",
      middleText: "Are you sure you want to remove this item from cart?",
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        AppLoaders.customToast(message: "Item removed from cart");
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    noOfCartItems.value = calculatedNoOfItems;
    totalCartPrice.value = calculatedTotalPrice;
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;

      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    AppLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price =
        isVariation
            ? variation.salePrice > 0.0
                ? variation.salePrice
                : variation.price
            : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : "",
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void loadCartItems() {
    final cartItemsStrings = AppLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    if (cartItemsStrings != null) {
      cartItems.assignAll(
        cartItemsStrings
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
