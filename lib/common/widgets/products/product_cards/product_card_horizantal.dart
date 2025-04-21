import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/images/app_rounded_images.dart';
import 'package:pomme_dapi/common/widgets/products/favorit_icon/favorit_icon.dart';
import 'package:pomme_dapi/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:pomme_dapi/common/widgets/texts/product_price_text.dart';
import 'package:pomme_dapi/common/widgets/texts/product_title_text.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class ProductCardHorizantal extends StatelessWidget {
  const ProductCardHorizantal({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    var isDark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withOpacity(0.1)),
        color: isDark ? AppColors.darkerGrey : AppColors.grey,
        borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
      ),
      child: Row(
        children: [
          AppRoundedContainer(
            height: 120,
            backgroundColor: isDark ? AppColors.dark : AppColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: AppRoundedImage(
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                ),
                Positioned(
                  top: 12,
                  child: AppRoundedContainer(
                    radius: AppSizes.sm,
                    backgroundColor: AppColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sm,
                      vertical: AppSizes.xs,
                    ),
                    child:
                        product.productType == ProductType.single.toString()
                            ? Text(
                              "$salePercentage%",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColors.black),
                            )
                            : Text(
                              "On Sale",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColors.black),
                            ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: 0,
                  child: FavoriteIcon(productId: product.id),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSizes.sm,
                left: AppSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(title: product.title, smallSize: true),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      BrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            if (product.salePrice > 0 &&
                                product.productType ==
                                    ProductType.single.toString())
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppSizes.sm,
                                ),
                                child: Text(
                                  "\$${product.price.toString()}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: AppSizes.sm),
                              child: ProductPriceText(
                                price: controller.getProductPrice(product),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.cardRadiusMd),
                            bottomRight: Radius.circular(AppSizes.cardRadiusMd),
                          ),
                        ),
                        child: const SizedBox(
                          width: AppSizes.iconLg * 1.2,
                          height: AppSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(Iconsax.add, color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
