import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'animation_loader.dart';

class BFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside of it.
      builder: (_) => PopScope(
        canPop: false,
        child: Center( // Centering the dialog to prevent overflow
          child: SingleChildScrollView( // Add this to prevent overflow
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure it takes up only the needed space
              children: [
                const SizedBox(height: 250), 
                BAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Stopping the currently open loading dialog.
  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the navigator
  }
}
