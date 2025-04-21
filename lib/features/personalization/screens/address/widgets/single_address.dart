import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/custom_shapes/container/app_rounded_container.dart';
import 'package:pomme_dapi/features/personalization/controllers/address_controller.dart';
import 'package:pomme_dapi/features/personalization/models/address_model.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: AppRoundedContainer(
          padding: const EdgeInsets.all(AppSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor:
              selectedAddress
                  ? AppColors.primary.withOpacity(0.5)
                  : Colors.transparent,
          borderColor:
              selectedAddress
                  ? Colors.transparent
                  : dark
                  ? AppColors.darkGrey
                  : AppColors.grey,
          margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color:
                      selectedAddress
                          ? dark
                              ? AppColors.light
                              : AppColors.dark.withOpacity(0.8)
                          : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.sm / 2),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.sm / 2),
                  Text(address.toString(), softWrap: true),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
