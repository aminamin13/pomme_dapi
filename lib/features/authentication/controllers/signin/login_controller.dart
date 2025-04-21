import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/data/repositories/user_repository.dart';
import 'package:pomme_dapi/features/personalization/controllers/user_controller.dart';
import 'package:pomme_dapi/features/personalization/models/user_model.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/helpers/network_manager.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final userController = Get.put(UserController());

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final random = Random();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("remember_me_email") ?? "";
    password.text = localStorage.read("remember_me_password") ?? "";
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "Signing in...",
        AppImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value == true) {
        localStorage.write("remember_me_email", email.text.trim());
        localStorage.write("remember_me_password", password.text.trim());
      }

      final UserCredentials = await AutheticationRepository.instance
          .signInWithEmailAndPassword(email.text.trim(), password.text.trim());
      AppFullScreenLoader.stopLoading();

      AutheticationRepository.instance.screenRedirect();
    } catch (e) {
      // show some Generic error to user
      AppFullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "Signing in...",
        AppImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials =
          await AutheticationRepository.instance.signInWithGoogle();

      final newUser = UserModel(
        id: userCredentials.user!.uid,
        firstName: userCredentials.user!.displayName!.split(' ')[0],
        lastName: userCredentials.user!.displayName!.split(' ')[1],
        email: userCredentials.user!.email ?? '',
        phoneNumber: userCredentials.user!.phoneNumber ?? '',
        userName:
            "${userCredentials.user!.displayName!.replaceAll(' ', "")}${random.nextInt(100)}",
        profilePicture: userCredentials.user!.photoURL ?? '',
        role: 'user',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // save user records

      final userRepository = Get.put(UserRepository());
      final exists = await userRepository.userExists(newUser.id!);

      if (!exists) {
        await userController.saveUserRecords(userCredentials);
        await userRepository.saveUserRecord(newUser);
      }

      AppFullScreenLoader.stopLoading();

      AutheticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
