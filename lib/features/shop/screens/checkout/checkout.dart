import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/features/personalization/controllers/settings_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/checkout_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/order_controller.dart';
import 'package:pomme_dapi/features/shop/screens/cart/widgets/cart_items_list.dart';
import 'package:pomme_dapi/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:pomme_dapi/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:pomme_dapi/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:pomme_dapi/utils/helpers/pricing_calculator.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());
    final settingController = Get.put(SettingsController());
    final checkOutController = Get.put(CheckOutController());

    final subTotal = controller.totalCartPrice.value;
    final tax = AppPricingCalculator.calculateTax(subTotal, 'Us');

    var dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            switch (checkOutController.selectedPaymentMethod.value.name) {
              case "Visa":
                checkOutController.paymentSheetInitialization(
                  (subTotal +
                          settingController.settings.value.shippingCost +
                          double.parse(tax))
                      .toString(),
                  "USD",
                );

                break;
              case "MasterCard":
                checkOutController.paymentSheetInitialization(
                  (subTotal +
                          settingController.settings.value.shippingCost +
                          double.parse(tax))
                      .toString(),
                  "USD",
                );
                break;

              case "Cash on Delivery":
                orderController.processOrder(
                  (subTotal +
                      settingController.settings.value.shippingCost +
                      double.parse(tax)),
                );
                break;
              default:
                AppLoaders.warningSnackBar(
                  title: "No Payment Method Selected",
                  message: "Please select a payment method to continue.",
                );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Obx(
            () => Text(
              "Checkout \$${subTotal + settingController.settings.value.shippingCost + double.parse(tax)}",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            const AppCartItems(showAddRemoveButtons: false),
            const SizedBox(height: AppSizes.defaultSpace),
            // const AppCouponCode(),
            // const SizedBox(height: AppSizes.spaceBtwSections),
            AppRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(AppSizes.md),
              backgroundColor: dark ? AppColors.black : AppColors.white,
              child: const Column(
                children: [
                  BillingAmountSection(),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  Divider(),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  BillingPaymentSection(),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  Divider(),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  BillingAddressSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
