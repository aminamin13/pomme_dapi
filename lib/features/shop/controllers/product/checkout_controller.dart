import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/personalization/controllers/settings_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/cart_controller.dart';
import 'package:pomme_dapi/features/shop/controllers/product/order_controller.dart';
import 'package:pomme_dapi/features/shop/models/payment_method_model.dart';
import 'package:pomme_dapi/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/pricing_calculator.dart';
import 'package:pomme_dapi/utils/keys/keys.dart';

class CheckOutController extends GetxController {
  static CheckOutController instance = Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
  Map<String, dynamic>? paymentIntentData;

  @override
  void onInit() {
    // TODO: implement onInit
    selectedPaymentMethod.value = PaymentMethodModel(
      name: "Cash on Delivery",
      image: AppImages.cashOnDelivery,
    );
    super.onInit();
  }

  Future<dynamic> selectPaymentMehtod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppSectionHeading(
                  title: "Select Payment Method",
                  showActionButton: false,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                // AppPaymentTile(
                //   paymentMethod: PaymentMethodModel(
                //     name: "PayPal",
                //     image: AppImages.paypal,
                //   ),
                // ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                // AppPaymentTile(
                //   paymentMethod: PaymentMethodModel(
                //     name: "Google Pay",
                //     image: AppImages.googlePay,
                //   ),
                // ),
                // const SizedBox(height: AppSizes.spaceBtwItems / 2),
                // AppPaymentTile(
                //   paymentMethod: PaymentMethodModel(
                //     name: "Apple Pay",
                //     image: AppImages.applePay,
                //   ),
                // ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                AppPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: "Visa",
                    image: AppImages.visa,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                AppPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: "MasterCard",
                    image: AppImages.masterCard,
                  ),
                ),
                // const SizedBox(height: AppSizes.spaceBtwItems / 2),
                // AppPaymentTile(
                //   paymentMethod: PaymentMethodModel(
                //     name: "PayStack",
                //     image: AppImages.paystack,
                //   ),
                // ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                // AppPaymentTile(
                //   paymentMethod: PaymentMethodModel(
                //     name: "Credit Card",
                //     image: AppImages.creditCard,
                //   ),
                // ),
                // const SizedBox(height: AppSizes.spaceBtwItems / 2),
                AppPaymentTile(
                  paymentMethod: PaymentMethodModel(
                    name: "Cash on Delivery",
                    image: AppImages.cashOnDelivery,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
              ],
            ),
          ),
        );
      },
    );
  }

  paymentSheetInitialization(amountToBeCharged, currency) async {
    try {
      paymentIntentData = await makeIntentForPayment(
        amountToBeCharged,
        currency,
      );
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              allowsDelayedPaymentMethods: true,
              paymentIntentClientSecret: paymentIntentData!["client_secret"],
              style: ThemeMode.dark,
              merchantDisplayName: "Pomme Dapi Store",
            ),
          )
          .then((value) {
            print(value);
          });
      showPaymentSheet(Get.context!);
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
      }
      print(e.toString());
    }
  }

  makeIntentForPayment(amountToBeCharged, currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount":
            (double.parse(amountToBeCharged.toString()) * 100)
                .toInt()
                .toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      print("Response from API = ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      print(e.toString());
    }
  }

  void showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) {
            paymentIntentData = null;
            final tax = AppPricingCalculator.calculateTax(
              CartController.instance.totalCartPrice.value,
              'Us',
            );

            final total =
                CartController.instance.totalCartPrice.value +
                SettingsController.instance.settings.value.shippingCost +
                num.parse(tax);

            OrderController.instance.processOrder(total);
          })
          .onError((e, s) {
            print("Payment canceled or failed");
          });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      print(e.toString());
    }
    showDialog(
      context: Get.context!,
      builder:
          (_) => const AlertDialog(
            content: Text("Payment Failed, Please Try again!"),
          ),
    );
  }

  oncatch(e, s) {
    if (kDebugMode) {
      print(s);
    }
    print(e.toString());
  }
}
