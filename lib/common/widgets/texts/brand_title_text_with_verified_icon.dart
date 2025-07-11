import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/texts/brand_title_text.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class BrandTitleWithVerifiedIcon extends StatelessWidget {
  const BrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = AppColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
          ),
        ),
        const SizedBox(width: AppSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: AppSizes.iconXs),
      ],
    );
  }
}
