import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/features/shop/controllers/product/checkout_controller.dart';
import 'package:pomme_dapi/features/shop/models/payment_method_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class AppPaymentTile extends StatelessWidget {
  const AppPaymentTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: AppRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor:
            AppHelperFunctions.isDarkMode(context)
                ? AppColors.light
                : AppColors.white,
        padding: const EdgeInsets.all(AppSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
