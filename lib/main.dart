

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:stride_delivery/auth/repository/user_repo.dart';

import 'app.dart';
import 'auth/repository/auth_repo.dart';





Future<void> main() async {
  /// widgets binding 
  
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); 

  /// getx local storage 
  await GetStorage.init();

  /// await splash until other items load

FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

/// iniitalize firebase and auth. repository
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
  (FirebaseApp value) {
     Get.put(
    AuthenticationRepository()); 
  
     Get.put(UserRepository()); 
  }

  ); 

  // load all the material design
   runApp(const MyApp());  
}