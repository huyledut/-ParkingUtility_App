import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class HomeController extends BaseController {
  HomeController(this._storageService);

  final StorageService _storageService;

  var customer = CustomerModel().obs;
  var checkOutString = "".obs;

  Rx<VehicalModel> vehicalQRCode = VehicalModel().obs;

  RxList<VehicalModel> vehicals = <VehicalModel>[].obs;

  Rx<int> selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    _storageService.getCustomer().then((value) {
      customer.value = CustomerModel.fromJson(jsonDecode(value));
      vehicals.value = (customer.value.vehicals ?? <VehicalModel>[]) as List<VehicalModel>;
      if (vehicals.isNotEmpty) {
        vehicalQRCode.value = vehicals.first;
      }
    });
  }

  void selectVehical(int index) {
    selectIndex.value = index;
    vehicalQRCode.value = vehicals[index];
  }

  var checkOutState = false.obs;
  var viewCheckOut = false.obs;

  void closeViewCheckOut() {
    viewCheckOut.value = false;
  }

  void checkOut() {
    // check out
  }
}
