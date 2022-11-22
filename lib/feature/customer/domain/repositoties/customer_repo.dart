import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_utility/feature/customer/data/providers/remote/request/customer_update_request.dart';

abstract class CustomerRepo {
  Future<CustomerModel> customerInfo();
  Future<List<FacultyModel>> getAllFaculty();
  Future<void> customerUpdate(CustomerUpdateRequest request);
}
