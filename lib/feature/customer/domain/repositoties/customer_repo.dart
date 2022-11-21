import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/customer/data/models/faculties_model.dart';

abstract class CustomerRepo {
  Future<CustomerModel> customerInfo();
  Future<List<FacultyModel>> getAllFaculty();
}
