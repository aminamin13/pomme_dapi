import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/features/authentication/controllers/signup/signup_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:pomme_dapi/utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());

    final dark = AppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            // email
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator:
                        (value) =>
                            AppValidator.validateEmptyText("First Name", value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: AppTexts.firstName,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: TextFormField(
                    validator:
                        (value) =>
                            AppValidator.validateEmptyText("Last Name", value),
                    controller: controller.lastName,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: AppTexts.lastName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            TextFormField(
              controller: controller.username,
              validator:
                  (value) => AppValidator.validateEmptyText("Username", value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_edit),
                labelText: AppTexts.username,
                suffix: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            TextFormField(
              controller: controller.email,
              validator: (value) => AppValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: AppTexts.email,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            TextFormField(
              validator: (value) => AppValidator.validatePhoneNumber(value),
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call),
                labelText: AppTexts.phoneNo,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Obx(
              () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.password,
                validator: (value) => AppValidator.validatePassword(value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: AppTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                    icon: Icon(
                      controller.hidePassword.value == true
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Obx(
                    () => Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) {
                        controller.privacyPolicy.value =
                            !controller.privacyPolicy.value;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppTexts.iAgreeTo,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: AppTexts.privacyPolicy,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? AppColors.white : AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: AppTexts.and,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: AppTexts.termsOfUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? AppColors.white : AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.signup();
                },
                child: const Text(AppTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
