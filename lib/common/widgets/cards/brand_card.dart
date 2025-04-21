import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/images/app_circular_image.dart';
import 'package:pomme_dapi/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:pomme_dapi/features/shop/models/brands_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brand,
  });
  final BrandModel brand;
  final bool showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppRoundedContainer(
        padding: const EdgeInsets.all(AppSizes.sm),
        showBorder: showBorder,
        borderColor:
            AppHelperFunctions.isDarkMode(context)
                ? AppColors.darkGrey
                : AppColors.borderPrimary,
        backgroundColor:
            AppHelperFunctions.isDarkMode(context)
                ? AppColors.dark
                : Colors.white,
        child: Row(
          children: [
            Flexible(
              child: AppCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                overlayColor:
                    AppHelperFunctions.isDarkMode(context)
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSizes: TextSizes.large,
                    iconColor: AppColors.primary,
                  ),
                  Text(
                    '${brand.productsCount ?? 0}'
                    " Products",
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
