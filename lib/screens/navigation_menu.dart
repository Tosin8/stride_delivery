
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stride_delivery/screens/deliveries.dart';
import 'package:stride_delivery/screens/overview.dart';
import 'package:stride_delivery/screens/tracking.dart';




class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: 75,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: Colors.white,
          indicatorColor: Colors.black,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
              icon: Icon(Iconsax.home, color: controller.selectedIndex.value == 0 ? Colors.white : Colors.grey),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.scroll, color: controller.selectedIndex.value == 1 ? Colors.white : Colors.grey),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.location, color: controller.selectedIndex.value == 2 ? Colors.white : Colors.grey),
              label: 'Track',
            ),
        
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Overview(),
    const Deliveries(),
     const TrackingScreen(deliveryAddress: '', customerName: '',), 
     
   
  ];
}
