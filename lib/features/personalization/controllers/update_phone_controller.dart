import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/user_repository.dart';
import 'package:pomme_dapi/features/personalization/controllers/user_controller.dart';
import 'package:pomme_dapi/features/personalization/screens/profile/profile_screen.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/helpers/network_manager.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/popups/full_screen_loader.dart';

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final userController = Get.put(UserController());

  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();
  final phone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  Future<void> initializeNames() async {
    phone.text = userController.user.value.phoneNumber;
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
      if (!updatePhoneFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'PhoneNumber': phone.text.trim(),
        'UpdatedAt': DateTime.now(),
      };
      await userRepository.updateSingleField(name);

      userController.user.value.phoneNumber = phone.text.trim();

      AppFullScreenLoader.stopLoading();

      AppLoaders.successSnackBar(title: "Success", message: "Phone Updated");

      Get.off(() => const ProfileScreen());
    } catch (e) {
      AppFullScreenLoader.stopLoading();

      AppLoaders.errorSnackBar(
        title: "Error",
        message: "Failed to update phone",
      );
    }
  }
}
