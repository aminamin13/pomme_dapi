import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/cards/brand_card.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/shimmer/brands_shimmer.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/product/brands_controller.dart';
import 'package:pomme_dapi/features/shop/screens/all_brands/brands_products.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandsController.instance;
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "All Brands",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              const AppSectionHeading(title: "Brands"),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Obx(() {
                if (brandController.isLoading.value) {
                  return const AppBrandsShimmer();
                }
                if (brandController.featuredBrands.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }
                return AppGridLayout(
                  padding: 0,
                  ItemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (p0, index) {
                    final brand = brandController.allBrands[index];

                    return BrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandsProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
