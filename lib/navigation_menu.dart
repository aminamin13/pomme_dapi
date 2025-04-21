import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/features/personalization/screens/settings/settings_screen.dart';
import 'package:pomme_dapi/features/shop/screens/home/homescreen.dart';
import 'package:pomme_dapi/features/shop/screens/store/storescreen.dart';
import 'package:pomme_dapi/features/shop/screens/wishlist/wishlist.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    NavigationMenuController controller = Get.put(
      NavigationMenuController(),
    ); // GetxController
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          height: 80,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          indicatorColor:
              dark
                  ? AppColors.white.withOpacity(0.1)
                  : AppColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
            NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        );
      }),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationMenuController extends GetxController {
  Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Homescreen(),
    const StoreScreen(),
    const WishListScreen(),
    const SettingsScreen(),
  ];
}
