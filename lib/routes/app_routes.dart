

import 'package:get/get.dart';
import 'package:stride/screens/cart/checkout.dart';
import 'package:stride/screens/shop/home/home.dart';


import '../auth/forms/login.dart';
import '../screens/splash.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: BRoutes.home, page: () => const HomeScreen()),
        GetPage(name: BRoutes.signIn, page: () => const LoginScreen()), 
        GetPage(name: BRoutes.splash, page: () => const SplashScreen()),
          GetPage(name: BRoutes.checkout, page: () => const CheckoutPage()),
        
        
      
  ]; 
}