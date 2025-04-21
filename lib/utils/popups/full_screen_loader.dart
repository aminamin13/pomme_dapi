import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';
import 'package:pomme_dapi/utils/popups/loaders.dart';

class AppFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  /// text: The text to be displayed in the loading dialog.
  /// animation: The Lottie animation to be shown.

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // overlay dialogs
      barrierDismissible:
          false, // we can't dismiss the dialog IF WE CLICK OUTSIDE IT
      builder:
          (_) => PopScope(
            canPop: false, // disbale popping with the back buttom
            child: Container(
              color:
                  AppHelperFunctions.isDarkMode(Get.context!)
                      ? AppColors.dark
                      : AppColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 250),
                    AppAnimationLoaderWidget(text: text, animation: animation),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
