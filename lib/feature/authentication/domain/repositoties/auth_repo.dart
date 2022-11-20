import 'package:dut_packing_utility/feature/authentication/data/providers/remote/request/username_password_request.dart';

import '../../data/models/account_model.dart';

abstract class AuthRepo {
  Future<AccountModel> login(UsernamePasswordRequest request);
}
