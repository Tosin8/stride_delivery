import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



import '../../utils/widgets/constants/images_c.dart';
import '../../utils/widgets/popups/loaders.dart';
import '../repository/auth_repo.dart';

class VerifyMailController extends GetxController{
  static VerifyMailController get instance => Get.find();

  /// send email whenever verify screen appear and set timer for auto redirect. 
  
  @override 
  void onInit() {
    sendEmailVerification(); 
    setTimerForAutoRedirect(); 
    super.onInit(); 
  }

  /// send email verification link 
  
  sendEmailVerification() async{
    try{
await AuthenticationRepository.instance.sendEmailVerification();
BLoaders.successSnackBar(
  title: 'Email Sent', 
  message: 'Please check your email for verification link'); 
    } 
    catch(e){
BLoaders.errorSnackBar(
  title: 'Oh Snap!', 
message: e.toString()); 
    }
  }
  /// timer to auto redirect an email verification
  
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), 
    (timer) async {
await FirebaseAuth.instance.currentUser?.reload(); 
final user = FirebaseAuth.instance.currentUser; 
if(user?.emailVerified ?? false) {
  timer.cancel(); 
  Get.off(
    () => SuccessScreen(
      image: SImages.successfullyRegisterAnimation, 
      title: 'BTexts.yourAccountCreatedTitle',
      subTitle: 'BTexts.yourAccountCreatedSubTitle',
      onTap: () => AuthenticationRepository.instance.screenRedirect(), 
    ),
  ); 
}
  }
  ); 
  }

  /// manually check if email verification. 
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: SImages.successfullyRegisterAnimation, 
          title: 'Your account is now created',
           subTitle: 'BTexts.yourAccountCreatedSubTitle', 
           onTap: () => AuthenticationRepository.instance.screenRedirect(),
           )
           ); 
    }
  }
}


