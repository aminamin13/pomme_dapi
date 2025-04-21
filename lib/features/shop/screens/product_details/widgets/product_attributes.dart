import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/chip/choice_chip.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/common/widgets/texts/product_price_text.dart';
import 'package:pomme_dapi/common/widgets/texts/product_title_text.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_variation_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller1 = Get.put(ProductVariationController());

    final dark = AppHelperFunctions.isDarkMode(context);
    return Obx(() {
      return Column(
        children: [
          if (controller1.selectedVariation.value.id.isNotEmpty)
            AppRoundedContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const AppSectionHeading(title: "Variation"),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      //actual price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const ProductTitleText(
                                title: "Price: ",
                                smallSize: true,
                              ),

                              // actual price
                              if (controller1
                                      .selectedVariation
                                      .value
                                      .salePrice >
                                  0)
                                Text(
                                  controller1.selectedVariation.value.price
                                      .toString(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),

                              const SizedBox(width: AppSizes.spaceBtwItems),
                              ProductPriceText(
                                price: controller1.getVariationPrice(),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     const ProductTitleText(
                          //       title: "Stock: ",
                          //       smallSize: true,
                          //     ),
                          //     Text(
                          //       "In Stock",
                          //       style: Theme.of(context).textTheme.titleMedium,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // ProductTitleText(
                  //   title: product.description.toString(),
                  //   maxLines: 4,
                  //   smallSize: true,
                  // ),
                ],
              ),
            ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                product.productAttributes!
                    .map(
                      (attribute) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSectionHeading(title: attribute.name ?? ""),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),
                          Obx(() {
                            return Wrap(
                              spacing: 8,
                              children:
                                  attribute.values!.map((attributeValue) {
                                    final isSelected =
                                        controller1.selectedAttributes[attribute
                                            .name] ==
                                        attributeValue;

                                    final available = controller1
                                        .getAttributeAvailabilityInVariation(
                                          product.productVariations!,
                                          attribute.name!,
                                        )
                                        .contains(attributeValue);

                                    return AppChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onSelected:
                                          available
                                              ? (selected) {
                                                if (selected && available) {
                                                  controller1
                                                      .onAttributeSelected(
                                                        product,
                                                        attribute.name ?? '',
                                                        attributeValue,
                                                      );
                                                }
                                              }
                                              : null,
                                    );
                                  }).toList(),
                            );
                          }),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ],
      );
    });
  }
}
