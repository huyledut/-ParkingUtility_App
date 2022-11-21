import 'package:dut_packing_utility/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_utility/feature/customer/domain/usecases/get_faculties_usecase.dart';
import 'package:get/get.dart';
import '../../controller/profile/profile_controller.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCustomerInfoUsecase(Get.find()));
    Get.lazyPut(() => GetFacultiesUsecase(Get.find()));
    Get.put(ProfileController(Get.find(), Get.find(), Get.find()));
  }
}
