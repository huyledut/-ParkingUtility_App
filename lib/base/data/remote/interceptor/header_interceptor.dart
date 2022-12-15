import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_utility/feature/authentication/data/models/account_model.dart';
import 'package:dut_packing_utility/utils/services/storage_service_impl.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    StorageServiceImpl().getToken().then((value) {
      if (value.isNotEmpty) {
        AccountModel account = AccountModel.fromJson(jsonDecode(value));
        options.headers["Authorization"] = "Bearer ${account.accessToken}";
      }
      handler.next(options);

      print("==================================");
      print(options.uri);
      print("==================================");
    });
  }
}
