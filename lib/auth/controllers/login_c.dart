import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stride/auth/repository/auth_repo.dart';

import '../../utils/http/network_manager.dart';
import '../../utils/widgets/constants/images_c.dart';
import '../../utils/widgets/popups/full_screen.dart';
import '../../utils/widgets/popups/loaders.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // Assign empty string if localStorage reads null to avoid null errors
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    // Form validation - Ensure the form is valid before doing anything else
   
    try {
      // Start loading
      BFullScreenLoader.openLoadingDialog('Logging you in...', SImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BFullScreenLoader.stopLoading();
        return;
      }

 if (!loginFormKey.currentState!.validate()) {
      BFullScreenLoader.stopLoading();
      return;
    }

      // Perform the login request here...
      // (Assumed that you handle the login process with API after this point)

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

// login user using Email & password authentication
final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
        // Remove loader
      BFullScreenLoader.stopLoading();
      email.clear();
      password.clear();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
      Get.delete<LoginController>();
    } catch (e) {
      BLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      BFullScreenLoader.stopLoading();
    }
  }
}
