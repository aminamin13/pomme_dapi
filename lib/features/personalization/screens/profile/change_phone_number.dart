import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/features/personalization/controllers/update_phone_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:pomme_dapi/utils/validators/validation.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        backgroundColor:
            AppHelperFunctions.isDarkMode(context)
                ? AppColors.dark
                : AppColors.white,
        title: Text(
          "Change Phone Number",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              "Use Real Phone Number for Easy Verification. This name will appear on several Pages",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Form(
              key: controller.updatePhoneFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phone,
                    validator:
                        (value) => AppValidator.validateEmptyText(
                          "Phone Number",
                          value,
                        ),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: AppTexts.phoneNo,
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),

                  const SizedBox(height: AppSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateUserName();
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
