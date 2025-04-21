import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/cards/brand_card.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/features/shop/screens/all_brands/brands_products.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class AppBrandShowCase extends StatelessWidget {
  const AppBrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    // Fetch products by brand and (optionally) category

    return GestureDetector(
      onTap: () {
        Get.to(() => BrandsProducts(brand: brand));
      },
      child: AppRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSizes.md),
        backgroundColor: Colors.transparent,
        borderColor: AppColors.darkGrey,
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [BrandCard(showBorder: false, brand: brand)],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, BuildContext context) {
  return Expanded(
    child: AppRoundedContainer(
      height: 100,
      backgroundColor:
          AppHelperFunctions.isDarkMode(context)
              ? AppColors.darkerGrey
              : AppColors.light,
      margin: const EdgeInsets.only(right: AppSizes.sm),
      padding: const EdgeInsets.all(AppSizes.md),
      child:
          image.isNotEmpty
              ? Image(fit: BoxFit.contain, image: NetworkImage(image))
              : const Icon(Icons.image_not_supported),
    ),
  );
}
