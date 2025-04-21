import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:pomme_dapi/common/widgets/images/app_rounded_images.dart';
import 'package:pomme_dapi/common/widgets/shimmer/shimmer_effect.dart';
import 'package:pomme_dapi/features/shop/controllers/banner_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppPromoSlider extends StatelessWidget {
  const AppPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        const AppShimmerEffect(width: double.infinity, height: 190);
      }
      if (controller.banners.isEmpty) {
        return const Center(child: Text("No Banners"));
      } else {
        return Column(
          children: [
            CarouselSlider(
              items:
                  controller.banners
                      .map(
                        (banner) => AppRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ),
                      )
                      .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  return controller.updatePageIndicator(index);
                },
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(controller.banners.length, (index) {
                    return AppCircularContainer(
                      height: 4,
                      width: 20,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carousalCurrentIndex.value == index
                              ? AppColors.primary
                              : AppColors.darkGrey,
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
