import 'package:dut_packing_utility/feature/customer/domain/usecases/change_password_usecase.dart';
import 'package:get/get.dart';
import '../../controller/change_password/change_password_controller.dart';

class ChangePasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordUsecase(Get.find()));
    Get.put(ChangePasswordController(Get.find()));
  }
}
