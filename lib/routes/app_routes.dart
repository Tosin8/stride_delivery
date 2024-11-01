

import 'package:get/get.dart';
import 'package:stride_delivery/screens/deliveries.dart';
import 'package:stride_delivery/screens/navigation_menu.dart';



import '../auth/forms/login.dart';

import '../screens/tracking.dart';
import 'routes.dart';

class AppRoutes {
  static final pages = [

        GetPage(name: BRoutes.signIn, page: () => const LoginScreen()), 
        
       GetPage(name: '/navigation', page: () => NavigationMenu()),
        GetPage(name: '/deliveryDetails', page: () => const DeliveryDetails(delivery: null,)),
        GetPage(name: '/tracking', page: () => const TrackingScreen(deliveryAddress: '', customerName: '')),      
        
        
      
  ]; 
}
