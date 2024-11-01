
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:stride_delivery/screens/deliveries.dart';
// import 'package:stride_delivery/screens/overview.dart';
// import 'package:stride_delivery/screens/tracking.dart';




// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
    
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           elevation: 0,
//           height: 75,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) => controller.selectedIndex.value = index,
//           backgroundColor: Colors.white,
//           indicatorColor: Colors.black,
//           labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           destinations: [
           
//             NavigationDestination(
//               icon: Icon(Iconsax.scroll, color: controller.selectedIndex.value == 0 ? Colors.white : Colors.grey),
//               label: 'Orders',
//             ),
//             NavigationDestination(
//               icon: Icon(Iconsax.location, color: controller.selectedIndex.value == 1 ? Colors.white : Colors.grey),
//               label: 'Track',
//             ),
        
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;

//   final screens = [
//     //const Overview(),
//     const Deliveries(),
//      const TrackingScreen(deliveryAddress: '', customerName: '',), 
     
   
//   ];
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stride_delivery/screens/tracking.dart';
import 'deliveries.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late final NavigationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NavigationController());

    // Retrieve any arguments passed during navigation and update index accordingly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map?;
      if (routeArgs != null) {
        final selectedScreen = routeArgs['screen'] as int;
        if (selectedScreen == 1) {
          controller.selectedIndex.value = 1; // Set index to TrackingScreen
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Iconsax.scroll,
                  color: controller.selectedIndex.value == 0 ? Colors.white : Colors.grey),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.location,
                  color: controller.selectedIndex.value == 1 ? Colors.white : Colors.grey),
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
    const Deliveries(),
    const TrackingScreen(deliveryAddress: '', customerName: ''),
  ];
}
