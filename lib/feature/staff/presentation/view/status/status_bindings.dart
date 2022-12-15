import 'package:dut_packing_utility/feature/customer/domain/usecases/get_status_usecase.dart';
import 'package:get/get.dart';
import '../../controller/status/status_controller.dart';

class StatusBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetStatusUsecase(Get.find()));
    Get.put(StatusController(Get.find(), Get.find()));
  }
}
