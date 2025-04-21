import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/shimmer/shimmer_effect.dart';

class AppBrandsShimmer extends StatelessWidget {
  const AppBrandsShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return AppGridLayout(
      ItemCount: itemCount,
      itemBuilder: (itemContext, index) {
        AppShimmerEffect(width: 300, height: 80);
        return null;
      },
    );
  }
}
