import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/products/ratings/rating_indicator_bar.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(backgroundImage: AssetImage(AppImages.user)),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text("John Doe", style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            const AppRatingBarIndicator(rating: 3.5),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text("12-Nov-2024", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const ReadMoreText(
          "This is a product description for green shoes. There are more things that can be added but i will not add more beacuse its for training purposes. when we connect to database you will have more data ",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show More",
          trimExpandedText: "Less",
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        AppRoundedContainer(
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amine's Store",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "12-Nov-2024",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const ReadMoreText(
                "Stores Review for the Customer. There are more things that can be added but i will not add more beacuse its for training purposes. when we connect to database you will have more data ",
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Show More",
                trimExpandedText: "Less",
                moreStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
                lessStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
      ],
    );
  }
}
