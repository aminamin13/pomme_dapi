import 'package:flutter/material.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppGridLayout extends StatelessWidget {
  const AppGridLayout({
    super.key,
    required this.ItemCount,
    this.mainAxisExtent = 280,
    required this.itemBuilder,
    this.padding = AppSizes.defaultSpace,
  });
  final int ItemCount;
  final double? mainAxisExtent;
  final double padding;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: AppSizes.gridViewSpacing,
        crossAxisSpacing: AppSizes.gridViewSpacing,
      ),
      itemCount: ItemCount,
      shrinkWrap: true,
      padding: EdgeInsets.all(padding),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
    );
  }
}
