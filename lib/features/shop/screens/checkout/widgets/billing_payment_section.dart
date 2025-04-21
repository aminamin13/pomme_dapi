import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/product/checkout_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckOutController());
    return Column(
      children: [
        AppSectionHeading(
          title: "Payment Method",
          onPressed: () {
            controller.selectPaymentMehtod(context);
          },
          buttonTitle: "Change",
          showActionButton: true,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              AppRoundedContainer(
                height: 35,
                width: 60,
                padding: const EdgeInsets.all(AppSizes.sm),
                backgroundColor: dark ? AppColors.light : AppColors.white,
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: AppSizes.defaultSpace),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
