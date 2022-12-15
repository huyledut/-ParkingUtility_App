import 'package:dut_packing_utility/feature/customer/data/models/list_status_model.dart';
import 'package:dut_packing_utility/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetStatusUsecase extends UseCase<ListStatusModel> {
  GetStatusUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<ListStatusModel> build() {
    return _customerRepo.availableCheckIns();
  }
}
