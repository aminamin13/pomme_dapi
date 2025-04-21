import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/product_details.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        // if the product have variation then show the product details for variaition selection

        // else add the product to cart
        if (product.productType == ProductType.single.toString()) {
          final cartItems = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItems);
        } else {
          Get.to(() => ProductDetail(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(
          product.id,
        );
        return Container(
          decoration: BoxDecoration(
            color:
                productQuantityInCart > 0 ? AppColors.primary : AppColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.cardRadiusMd),
              bottomRight: Radius.circular(AppSizes.cardRadiusMd),
            ),
          ),
          child: SizedBox(
            width: AppSizes.iconLg * 1.2,
            height: AppSizes.iconLg * 1.2,
            child: Center(
              child:
                  productQuantityInCart > 0
                      ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: AppColors.white),
                      )
                      : const Icon(Iconsax.add, color: AppColors.white),
            ),
          ),
        );
      }),
    );
  }
}
