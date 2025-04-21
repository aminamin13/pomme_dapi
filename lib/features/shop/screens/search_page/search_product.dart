import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:pomme_dapi/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:pomme_dapi/features/shop/controllers/product/search_product_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/device/device_utility.dart';
import 'package:pomme_dapi/utils/helpers/cloud_helper_functions.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class SearchProducts extends StatelessWidget {
  const SearchProducts({super.key, this.query, this.futureMethod});

  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchProductController());
    final dark = AppHelperFunctions.isDarkMode(context);
    controller.fetchAllProducts();

    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "All Products",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Search Bar
              Container(
                width: AppDeviceUtils.getScreenWidth(context),
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: dark ? AppColors.dark : AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                ),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Search in Store",
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Iconsax.search_normal,
                      color: AppColors.darkerGrey,
                    ),
                  ),
                  onChanged: (value) => controller.searchProducts(value),
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              FutureBuilder<List<ProductModel>>(
                future: futureMethod ?? controller.fetchAllProducts(),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer();

                  final widget = AppCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  return Obx(() {
                    final isSearching = controller.searchQuery.value.isNotEmpty;

                    if (isSearching && controller.searchResults.isEmpty) {
                      // Search active, no results — show nothing
                      return const SizedBox();
                    }

                    if (!isSearching && controller.products.isEmpty) {
                      // Not searching and products not loaded yet — show nothing
                      return const SizedBox();
                    }

                    final itemCount =
                        isSearching
                            ? controller.searchResults.length
                            : controller.products.length;

                    return AppGridLayout(
                      padding: 10,
                      ItemCount: itemCount,
                      itemBuilder: (context, index) {
                        final product =
                            isSearching
                                ? controller.searchResults[index]
                                : controller.products[index];
                        return ProductCardVertical(product: product);
                      },
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
