import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/style/spacing_styles.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// image
              Center(
                child: Image(
                  image: AssetImage(image),
                  width: AppHelperFunctions.screenWidth() * 0.8,
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),

              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              // Text(
              //   AppTexts.confirmEmailSubTitle,
              //   style: Theme.of(context).textTheme.labelMedium,
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(AppTexts.tContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
