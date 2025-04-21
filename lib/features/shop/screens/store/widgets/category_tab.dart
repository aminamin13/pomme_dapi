import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:pomme_dapi/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/category_controller.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/features/shop/screens/all_products/all_product.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/cloud_helper_functions.dart';

class AppCategoryTab extends StatelessWidget {
  const AppCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // CategoryBrands(category: category),
              //const SizedBox(height: AppSizes.spaceBtwItems),
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final widget = AppCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const VerticalProductShimmer(),
                  );
                  if (widget != null) {
                    return widget;
                  } else {
                    final products = snapshot.data!;
                    return Column(
                      children: [
                        AppSectionHeading(
                          title: "",
                          onPressed: () {
                            Get.to(
                              () => AllProducts(
                                title: category.name,
                                futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id,
                                  limit: -1,
                                ),
                              ),
                            );
                          },
                          buttonTitle: "View All",
                          showActionButton: true,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        AppGridLayout(
                          padding: 0,
                          ItemCount: products.length,
                          itemBuilder: (p0, index) {
                            return ProductCardVertical(
                              product: products[index],
                            );
                          },
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
