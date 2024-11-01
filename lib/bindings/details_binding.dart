import 'package:get/get.dart';
import '../screens/deliveries.dart';


class DeliveryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final delivery = Get.arguments as Delivery;
    Get.put(delivery);
  }
}
