import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';

abstract class CustomerRepo {
  Future<CustomerModel> customerInfo();
}
