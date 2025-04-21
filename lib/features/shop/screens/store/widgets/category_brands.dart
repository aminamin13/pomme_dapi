import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/cards/brands_card.dart';
import 'package:pomme_dapi/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:pomme_dapi/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:pomme_dapi/features/shop/controllers/product/brands_controller.dart';
import 'package:pomme_dapi/features/shop/models/category_model.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandsController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            AppListTileShimmer(),
            SizedBox(height: AppSizes.spaceBtwItems),
            AppBoxShimmer(),
            SizedBox(height: AppSizes.spaceBtwItems),
          ],
        );
        final widget = AppCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = AppCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return AppBrandShowCase(
                  brand: brand,
                  images: products.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
