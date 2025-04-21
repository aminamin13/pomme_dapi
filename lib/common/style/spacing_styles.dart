import 'package:flutter/material.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    bottom: AppSizes.defaultSpace,
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
  );
}
