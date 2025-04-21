import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/productscart/cart_items.dart';
import 'package:pomme_dapi/common/widgets/productscart/priduct_quantity_with_add_remove.dart';
import 'package:pomme_dapi/common/widgets/texts/product_price_text.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class AppCartItems extends StatelessWidget {
  const AppCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Obx(() {
            final item = controller.cartItems[index];
            return Column(
              children: [
                AppCartItem(cartItem: item),
                if (showAddRemoveButtons)
                  const SizedBox(height: AppSizes.spaceBtwItems),
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          AppProductQuantityWithAddRemove(
                            quantity: item.quantity,
                            remove: () => controller.removeOneFromCart(item),
                            add: () => controller.addOneToCart(item),
                          ),
                        ],
                      ),
                      ProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1),
                      ),
                    ],
                  ),
              ],
            );
          });
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: AppSizes.spaceBtwSections);
        },
        itemCount: controller.cartItems.length,
      ),
    );
  }
}
