import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/shimmer/shimmer_effect.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = AppSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius:
              applyImageRadius
                  ? BorderRadius.circular(AppSizes.md)
                  : BorderRadius.zero,
          child: GestureDetector(
            child:
                isNetworkImage
                    ? CachedNetworkImage(
                      fit: fit,
                      imageUrl: imageUrl,
                      progressIndicatorBuilder:
                          (context, url, progress) =>
                              const AppShimmerEffect(width: 150, height: 180),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    )
                    : Image.asset(imageUrl, fit: fit),
          ),
        ),
      ),
    );
  }
}
