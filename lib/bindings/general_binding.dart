
import 'package:get/get.dart';

import '../auth/controllers/login_c.dart';
import '../utils/http/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager()); 
     Get.lazyPut(() => LoginController(), fenix: true);
  }
}