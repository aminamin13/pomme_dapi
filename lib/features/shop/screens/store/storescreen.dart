import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/cards/brand_card.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/search_container.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/productscart/cart_menu_icon.dart';
import 'package:pomme_dapi/common/widgets/shimmer/brands_shimmer.dart';
import 'package:pomme_dapi/common/widgets/tabbar/tab_bar.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/category_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/brands_controller.dart';
import 'package:pomme_dapi/features/shop/screens/all_brands/all_brands.dart';
import 'package:pomme_dapi/features/shop/screens/all_brands/brands_products.dart';
import 'package:pomme_dapi/features/shop/screens/store/widgets/category_tab.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandsController());
    final categoires = CategoryController.instance.featureCategories;
    return DefaultTabController(
      length: categoires.length,
      child: Scaffold(
        appBar: AppAppBar(
          backgroundColor:
              AppHelperFunctions.isDarkMode(context)
                  ? AppColors.dark
                  : AppColors.white,
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
              child: AppCartCounterItem(
                iconColor:
                    AppHelperFunctions.isDarkMode(context)
                        ? AppColors.white
                        : AppColors.black,
                textColor:
                    AppHelperFunctions.isDarkMode(context)
                        ? AppColors.black
                        : AppColors.white,
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: 440,
                backgroundColor:
                    AppHelperFunctions.isDarkMode(context)
                        ? AppColors.dark
                        : AppColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const AppSearchContainer(
                        text: "Search in Store",
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                      AppSectionHeading(
                        title: "Featured Brands",
                        onPressed: () => Get.to(const AllBrandsScreen()),
                        showActionButton: true,
                        textColor:
                            AppHelperFunctions.isDarkMode(context)
                                ? AppColors.grey
                                : Colors.black,
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const AppBrandsShimmer();
                        }
                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              "No Brands Found",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return AppGridLayout(
                          padding: 0,
                          ItemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (p0, index) {
                            final brand = brandController.featuredBrands[index];

                            return BrandCard(
                              showBorder: true,
                              brand: brand,
                              onTap:
                                  () => Get.to(
                                    () => BrandsProducts(brand: brand),
                                  ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                bottom: AppTabBar(
                  tabs:
                      categoires
                          .map((cateogry) => Tab(text: cateogry.name))
                          .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children:
                categoires
                    .map((category) => AppCategoryTab(category: category))
                    .toList(),
          ),
        ),
      ),
    );
  }
}
