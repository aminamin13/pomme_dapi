import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/features/shop/screens/cart/cart.dart';

class AppCartCounterItem extends StatelessWidget {
  const AppCartCounterItem({super.key, this.iconColor, this.textColor});

  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartScreen());
            },
            icon: Icon(Iconsax.shopping_bag, color: iconColor),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Obx(
                  () => Text(
                    controller.noOfCartItems.value.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: textColor,
                      fontSizeFactor: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
