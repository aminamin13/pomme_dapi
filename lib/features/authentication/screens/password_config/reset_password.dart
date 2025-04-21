import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/features/authentication/controllers/forgetpassword/forget_password_controller.dart';
import 'package:pomme_dapi/features/authentication/screens/login/login.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(AppImages.deliveredEmailIllustration),
                width: AppHelperFunctions.screenWidth() * 0.8,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(email, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Text(AppTexts.done),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              TextButton(
                onPressed: () {
                  ForgetPasswordController.instance.resendPasswordResetEmail(
                    email,
                  );
                },
                child: const Text(AppTexts.resendEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
