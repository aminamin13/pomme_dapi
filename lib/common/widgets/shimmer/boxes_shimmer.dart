import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/shimmer/shimmer_effect.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppBoxShimmer extends StatelessWidget {
  const AppBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: AppShimmerEffect(height: 110, width: 150)),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(child: AppShimmerEffect(height: 110, width: 150)),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(child: AppShimmerEffect(height: 110, width: 150)),
          ],
        ),
      ],
    );
  }
}
