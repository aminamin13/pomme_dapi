import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/success_screen/success_screen.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email whenever verify screen appeares and set timer for auto redricate

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    // TODO: implement onInit
    super.onInit();
  }

  // send email verification link
  sendEmailVerification() async {
    try {
      await AutheticationRepository.instance.sendEmailVerification();
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Please check your email for verification link",
      );
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  // Timer to automaticlly redricate on email verification

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: AppImages.staticSuccessIllustration,
            title: AppTexts.yourAccountCreatedTitle,
            subtitle: AppTexts.yourAccountCreatedSubTitle,
            onPressed: () {
              AutheticationRepository.instance.screenRedirect();
            },
          ),
        );
      }
    });
  }

  // manually check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && !currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: AppImages.staticSuccessIllustration,
          title: AppTexts.yourAccountCreatedTitle,
          subtitle: AppTexts.yourAccountCreatedSubTitle,
          onPressed: () {
            AutheticationRepository.instance.screenRedirect();
          },
        ),
      );
    }
  }
}
