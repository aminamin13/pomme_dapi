import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/data/repositories/user_repository.dart';
import 'package:pomme_dapi/features/authentication/screens/signup/verify_email.dart';
import 'package:pomme_dapi/features/personalization/models/user_model.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/helpers/network_manager.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// variables

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Signup Methods

  Future<void> signup() async {
    try {
      //start loading
      AppFullScreenLoader.openLoadingDialog(
        "We are processing your information...",
        AppImages.docerAnimation,
      );

      // Check Internet Connection

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // form Validation
      if (!signupFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        AppLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message: "In order to proceed, you must accept our Privacy Policy",
        );
        AppFullScreenLoader.stopLoading();

        return;
      }
      // register user in the firbase authentication and save  user data to firebasee
      final userCredential = await AutheticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
        role: "user",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove the loader from the screen
      AppFullScreenLoader.stopLoading();

      // show success message
      AppLoaders.successSnackBar(
        title: "Success",
        message: "Account created successfully",
      );

      // move to verify email screen

      Get.off(() => verifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // show some Generic error to user
      AppFullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    email.dispose();
    lastName.dispose();
    firstName.dispose();
    username.dispose();
    password.dispose();
    phoneNumber.dispose();
  }
}
