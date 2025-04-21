import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:pomme_dapi/common/widgets/listTile/settings_menu_tile.dart';
import 'package:pomme_dapi/common/widgets/listTile/user_profile_tile.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/features/personalization/controllers/settings_controller.dart';
import 'package:pomme_dapi/features/personalization/screens/address/address.dart';
import 'package:pomme_dapi/features/shop/screens/cart/cart.dart';
import 'package:pomme_dapi/features/shop/screens/orders/order.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppPrimaryHeaderContainer(
              child: Column(
                children: [
                  AppAppBar(
                    title: Text(
                      "Account",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.apply(color: AppColors.white),
                    ),
                  ),

                  // user profile Card
                  const AppUserProfile(),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  const AppSectionHeading(title: "Account Settings"),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  AppSettingMenuTile(
                    onTap: () {
                      Get.to(const AddressScreen());
                    },
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                  ),
                  AppSettingMenuTile(
                    onTap: () => Get.to(const CartScreen()),
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                  ),
                  AppSettingMenuTile(
                    onTap: () {
                      Get.to(const OrderScreen());
                    },
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                  ),
                  // const AppSettingMenuTile(
                  //   icon: Iconsax.bank,
                  //   title: 'Bank Account',
                  //   subtitle: 'Withdraw balance to registered bank account',
                  // ),
                  // const AppSettingMenuTile(
                  //   icon: Iconsax.discount_shape,
                  //   title: 'My Coupons',
                  //   subtitle: 'List of all the discounted coupons',
                  // ),

                  // const AppSettingMenuTile(
                  //   icon: Iconsax.security_card,
                  //   title: 'Account Privacy',
                  //   subtitle: 'Manage data usage and connected accounts',
                  // ),

                  /// App Settings
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  const AppSectionHeading(title: 'App Settings'),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // AppSettingMenuTile(
                  //   onTap: () => Get.to(const LoadDataScreen()),
                  //   icon: Iconsax.document_upload,
                  //   title: 'Load Data',
                  //   subtitle: 'Upload Data to your Cloud Firebase',
                  // ),
                  Obx(
                    () => AppSettingMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subtitle: 'Set any kind of notification message',
                      trailing: Switch(
                        value: controller.isNotificationOn.value,
                        onChanged: (value) {
                          controller.updateNotificationSetting(value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  AppSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ), // TSettingsMenuTile
                  // AppSettingMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Safe Mode',
                  //   subtitle: 'Search result is safe for all ages',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ), // TSettings MenuTile
                  // AppSettingMenuTile(
                  //   icon: Iconsax.image,
                  //   title: 'HD Image Quality',
                  //   subtitle: 'Set image quality to be seen',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ), // TSettings MenuTile
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        AutheticationRepository.instance.logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
