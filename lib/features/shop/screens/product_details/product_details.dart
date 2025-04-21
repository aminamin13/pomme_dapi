import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/widgets/button_add_to_cart.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButtonAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1- Product Image slider
            AppProductImageSlider(product: product),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: AppSizes.defaultSpace,
                left: AppSizes.defaultSpace,
                bottom: AppSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // rating & share
                  //AppRatingandShare(product: product,),
                  //price title, stock and brand
                  AppProductMetaData(product: product),

                  // attributes
                  if (product.productType == ProductType.variable.toString())
                    ProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(height: AppSizes.spaceBtwSections),
                  // checkoutbuttom
                  product.stock > 0
                      ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed("/checkout");
                          },
                          child: const Text("Checkout"),
                        ),
                      )
                      : SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: null,
                          child: const Text("Out of stock"),
                        ),
                      ),

                  // description
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  const AppSectionHeading(title: "Description"),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show More",
                    trimExpandedText: "Less",
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Divider(),
                  // const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const AppSectionHeading(
                  //       title: "Reviews(999)",
                  //       showActionButton: false,
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         Get.to(const ProductReviewsScreen());
                  //       },
                  //       icon: const Icon(Iconsax.arrow_right_3, size: 18),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  //reviews
                ],
              ),
            ),

            ///
          ],
        ),
      ),
    );
  }
}
