import 'package:flutter/material.dart';
import 'package:pomme_dapi/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/device/device_utility.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;

    final dark = AppHelperFunctions.isDarkMode(context);

    return Positioned(
      top: AppDeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          controller.skippage();
        },
        child: Text(
          'Skip',
          style: TextStyle(color: dark ? AppColors.light : AppColors.dark),
        ),
      ),
    );
  }
}
