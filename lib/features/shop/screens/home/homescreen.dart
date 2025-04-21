import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/search_container.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:pomme_dapi/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_controller.dart';
import 'package:pomme_dapi/features/shop/screens/all_products/all_product.dart';
import 'package:pomme_dapi/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:pomme_dapi/features/shop/screens/home/widgets/home_categories.dart';
import 'package:pomme_dapi/features/shop/screens/home/widgets/home_promo_banner.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(),
                  SizedBox(height: AppSizes.spaceBtwSections),

                  /// Searach Bar
                  AppSearchContainer(text: "Search in Store"),
                  SizedBox(height: AppSizes.spaceBtwSections),

                  /// Categories
                  ///
                  /// Padding(
                  Padding(
                    padding: EdgeInsets.only(left: AppSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: AppColors.light,
                        ),
                        SizedBox(height: AppSizes.spaceBtwItems),
                        AppHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwSections / 2),
                ],
              ),
            ),

            ///Body Part
            ///
            const Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: AppPromoSlider(),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppSectionHeading(
              title: "Popular Products",
              showActionButton: true,
              onPressed: () {
                Get.to(
                  AllProducts(
                    title: "Popular Products",
                    query: FirebaseFirestore.instance
                        .collection("Products")
                        .where("IsFeatured", isEqualTo: true)
                        .limit(6),
                    futureMethod: controller.fetchAllFeatureProducts(),
                  ),
                );
              },
              textColor:
                  AppHelperFunctions.isDarkMode(context)
                      ? AppColors.light
                      : AppColors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace,
              ),
            ),

            Obx(() {
              if (controller.isLoading.value) {
                const VerticalProductShimmer();
              }
              if (controller.featuredProducts.isEmpty) {
                return const Center(child: Text("No Products Found"));
              }
              return AppGridLayout(
                ItemCount: controller.featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCardVertical(
                    product: controller.featuredProducts[index],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
