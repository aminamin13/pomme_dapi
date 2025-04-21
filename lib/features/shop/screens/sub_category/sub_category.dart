import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/images/app_rounded_images.dart';
import 'package:pomme_dapi/common/widgets/products/product_cards/product_card_horizantal.dart';
import 'package:pomme_dapi/common/widgets/shimmer/horizantal_product_shimmer.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/category_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/all_product_controller.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/features/shop/screens/all_products/all_product.dart';
import 'package:pomme_dapi/features/shop/screens/product_details/product_details.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final productController = Get.put(AllProductsController());

    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            // AppRoundedImage(
            //   imageUrl: category.image,
            //   width: 25,
            //   applyImageRadius: true,
            //   isNetworkImage: true,
            // ),
            // const SizedBox(height: AppSizes.spaceBtwItems),
            FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const HorizantalProductShimmer();
                } else if (snapshot.hasError) {
                  // Handle error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return const Center(child: Text('No subcategories found'));
                }

                final subCategories = snapshot.data as List<CategoryModel>;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {
                    final subCategory = subCategories[index];
                    return FutureBuilder(
                      future: controller.getCategoryProducts(
                        categoryId: subCategory.id,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const HorizantalProductShimmer();
                        } else if (snapshot.hasError) {
                          // Handle error
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            (snapshot.data as List).isEmpty) {
                          return Center(
                            child: Text(
                              'No products found for ${subCategory.name}',
                            ),
                          );
                        }

                        final products = snapshot.data as List<ProductModel>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSectionHeading(
                              title: subCategory.name,
                              showActionButton: true,
                              onPressed: () {
                                Get.to(
                                  () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod: controller
                                        .getCategoryProducts(
                                          categoryId: subCategory.id,
                                          limit: -1,
                                        ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems / 2),
                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: AppSizes.spaceBtwItems / 2,
                                  );
                                },

                                itemCount: products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap:
                                        () => Get.to(
                                          () => ProductDetail(
                                            product: products[index],
                                          ),
                                        ),

                                    child: ProductCardHorizantal(
                                      product: products[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
