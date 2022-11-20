import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/customer/data/providers/remote/customer_api.dart';
import 'package:dut_packing_utility/feature/customer/domain/repositoties/customer_repo.dart';

class CustomerRepoImpl implements CustomerRepo {
  final _customerAPI = Get.find<CustomerAPI>();

  @override
  Future<CustomerModel> customerInfo() {
    return _customerAPI.customerInfo();
  }
}
