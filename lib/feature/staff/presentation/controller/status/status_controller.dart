import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/feature/authentication/data/models/account_model.dart';
import 'package:dut_packing_utility/feature/customer/data/models/status_model.dart';
import 'package:dut_packing_utility/feature/customer/domain/usecases/get_status_usecase.dart';
import 'package:dut_packing_utility/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class StatusController extends BaseController {
  StatusController(this._storageService, this._getStatusUsecase);

  final StorageService _storageService;
  final GetStatusUsecase _getStatusUsecase;

  var loadPageState = true.obs;
  var account = AccountModel();
  RxList<StatusModel> historys = <StatusModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPage();
  }

  void loadPage() {
    _storageService.getToken().then((value) {
      account = AccountModel.fromJson(jsonDecode(value));
      _getStatusUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            loadPageState.value = true;
          },
          onSuccess: (listStatus) async {
            loadPageState.value = false;
            historys.value = listStatus.getListHistory();
          },
          onError: (e) async {
            if (e is DioError) {
              if (e.response != null) {
                print(e.response!.data['errors'].toString());
              } else {
                print(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            loadPage();
          },
        ),
      );
    });
  }
}
