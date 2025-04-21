import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/icons/app_circular_icon.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class AppButtonAddToCart extends StatelessWidget {
  const AppButtonAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
          topRight: Radius.circular(AppSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppCircularIcon(
                  onPressed:
                      () =>
                          cartController.productQuantityInCart.value < 1
                              ? null
                              : cartController.productQuantityInCart.value -= 1,
                  icon: Iconsax.minus,
                  backgroundColor: AppColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: AppColors.white,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text(
                  cartController.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                AppCircularIcon(
                  onPressed:
                      () => cartController.productQuantityInCart.value += 1,
                  icon: Iconsax.add,
                  backgroundColor: AppColors.black,
                  width: 40,
                  height: 40,
                  color: AppColors.white,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                cartController.productQuantityInCart.value < 1
                    ? null
                    : cartController.addToCart(product);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: AppColors.black,
                side: const BorderSide(color: AppColors.black),
              ),
              child: const Text("Add To Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
