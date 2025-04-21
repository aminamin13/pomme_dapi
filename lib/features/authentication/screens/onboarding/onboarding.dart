import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:pomme_dapi/features/authentication/screens/onboarding/widgets/onboarder_next_button.dart';
import 'package:pomme_dapi/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:pomme_dapi/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:pomme_dapi/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizantal Scrollable Pages
          PageView(
            controller: controller.pagecontroller,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                title: AppTexts.onBoardingTitle1,
                subtitle: AppTexts.onBoardingSubTitle1,
                image: AppImages.onBoardingImage1,
              ),
              OnboardingPage(
                title: AppTexts.onBoardingTitle2,
                subtitle: AppTexts.onBoardingSubTitle2,
                image: AppImages.onBoardingImage2,
              ),
              OnboardingPage(
                title: AppTexts.onBoardingTitle3,
                subtitle: AppTexts.onBoardingSubTitle3,
                image: AppImages.onBoardingImage3,
              ),
            ],
          ),

          /// Skip button
          const OnBoardingSkip(),

          ///  Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingSkipButton(),
        ],
      ),
    );
  }
}
