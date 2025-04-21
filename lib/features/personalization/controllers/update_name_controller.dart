import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/user_repository.dart';
import 'package:pomme_dapi/features/personalization/controllers/user_controller.dart';
import 'package:pomme_dapi/features/personalization/screens/profile/profile_screen.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/helpers/network_manager.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final userController = Get.put(UserController());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final random = Random();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "Updating...",
        AppImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }
      if (!updateUserNameFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
        "UserName":
            "${firstName.text.trim().replaceAll(' ', "")}${lastName.text.trim().replaceAll(' ', "")}${random.nextInt(100)}",

        'UpdatedAt': DateTime.now(),
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      AppFullScreenLoader.stopLoading();

      AppLoaders.successSnackBar(title: "Success", message: "Name Updated");

      Get.off(() => const ProfileScreen());
    } catch (e) {
      AppFullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(
        title: "Error",
        message: "Failed to update name",
      );
    }
  }
}
