import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/layout/grid_layout.dart';
import 'package:pomme_dapi/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:pomme_dapi/features/shop/controllers/product/all_product_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppSortableProducts extends StatelessWidget {
  const AppSortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AllProductsController(),
    ); // Use Get.find to get the existing controller
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            if (value != null) {
              controller.sortProduct(value);
            }
          },
          items:
              [
                "Name",
                "Highest Price",
                "Lowest Price",
                "Most Recent",
                "Sale",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        Obx(
          () => AppGridLayout(
            padding: 10,
            ItemCount: controller.products.length,
            itemBuilder: (p0, index) {
              return ProductCardVertical(product: controller.products[index]);
            },
          ),
        ),
      ],
    );
  }
}
