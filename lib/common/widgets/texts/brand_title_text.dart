import 'package:flutter/material.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      style:
          brandTextSizes == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : brandTextSizes == TextSizes.medium
              ? Theme.of(context).textTheme.labelLarge!.apply(color: color)
              : brandTextSizes == TextSizes.large
              ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
              : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
