import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/features/personalization/controllers/address_controller.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          "Add New Address",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
            vertical: AppSizes.defaultSpace,
          ),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // email
                TextFormField(
                  controller: controller.name,
                  validator:
                      (value) => AppValidator.validateEmptyText("Name", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: AppValidator.validatePhoneNumber,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: AppTexts.phoneNo,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator:
                            (value) =>
                                AppValidator.validateEmptyText("Street", value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: "Street",
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator:
                            (value) => AppValidator.validateEmptyText(
                              "Postal Code",
                              value,
                            ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: "Postal Code",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator:
                            (value) =>
                                AppValidator.validateEmptyText("City", value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: "City",
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator:
                            (value) =>
                                AppValidator.validateEmptyText("State", value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: "State",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                TextFormField(
                  controller: controller.country,
                  validator:
                      (value) =>
                          AppValidator.validateEmptyText("Country", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: "Country",
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewAddresses();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
