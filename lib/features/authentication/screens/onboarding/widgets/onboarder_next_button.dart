import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/device/device_utility.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;

    final dark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: AppDeviceUtils.getBottomNavigationBarHeight(),
      right: AppSizes.defaultSpace,
      child: ElevatedButton(
        onPressed: () {
          controller.nextPage();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: AppColors.primary,
        ),
        child: Icon(
          Iconsax.arrow_right_3,
          color: dark ? AppColors.dark : AppColors.white,
        ),
      ),
    );
  }
}
