import 'package:get/get.dart';
import '../../controller/setting/setting_controller.dart';

class SettingBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingController(Get.find()));
  }
}
