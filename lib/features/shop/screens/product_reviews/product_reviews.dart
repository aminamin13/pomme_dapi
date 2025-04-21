import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/products/ratings/rating_indicator_bar.dart';
import 'package:pomme_dapi/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:pomme_dapi/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "Reviews & Ratings",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rating and reviews are verified and are from people who use the same type of device that you use",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const OverAllProductRating(),
            const AppRatingBarIndicator(rating: 3.5),
            Text("12,1212", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const UserReviewCard(),
            const UserReviewCard(),
            const UserReviewCard(),
          ],
        ),
      ),
    );
  }
}
