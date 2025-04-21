import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/images/app_circular_image.dart';
import 'package:pomme_dapi/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:pomme_dapi/common/widgets/texts/product_price_text.dart';
import 'package:pomme_dapi/common/widgets/texts/product_title_text.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:share_plus/share_plus.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                product.stock > 0
                    ? AppRoundedContainer(
                      radius: AppSizes.sm,
                      backgroundColor: AppColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                        vertical: AppSizes.xs,
                      ),
                      child: Text(
                        "On Sale",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    )
                    : AppRoundedContainer(
                      radius: AppSizes.sm,
                      backgroundColor: AppColors.error.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                        vertical: AppSizes.xs,
                      ),
                      child: Text(
                        "Sold",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                if (product.salePrice > 0)
                  Text(
                    "\$${product.price}",
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                ProductPriceText(
                  price: controller.getProductPrice(product),
                  isLarge: true,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      // Download image from URL
                      final response = await http.get(
                        Uri.parse(product.thumbnail),
                      );
                      final bytes = response.bodyBytes;

                      // Get local temporary directory
                      final dir = await getTemporaryDirectory();
                      final file = File('${dir.path}/shared_image.jpg');

                      // Save the image file
                      await file.writeAsBytes(bytes);

                      // Share the downloaded file
                      await Share.shareXFiles([
                        XFile(file.path),
                      ], text: product.title);
                    } catch (e) {
                      print('Error sharing file: $e');
                    }
                  },
                  icon: const Icon(Icons.share, size: AppSizes.iconMd),
                ),
              ],
            ),
          ],
        ),

        // name
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        ProductTitleText(title: product.title),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

        // stock
        Row(
          children: [
            const ProductTitleText(title: "Stock: "),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Row(
          children: [
            AppCircularImage(
              isNetworkImage: true,
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: dark ? Colors.white : Colors.black,
              backgroundColor: Colors.transparent,
            ),
            BrandTitleWithVerifiedIcon(
              title: product.brand!.name,
              iconColor: AppColors.primary,
              brandTextSizes: TextSizes.medium,
            ),
          ],
        ),
        // brand
      ],
    );
  }
}
