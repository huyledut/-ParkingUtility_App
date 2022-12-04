import 'dart:convert';
import 'package:dut_packing_utility/feature/staff/domain/usecases/create_check_out_usecase.dart';
import "package:intl/intl.dart";

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/staff/domain/usecases/create_check_in_usecase.dart';
import 'package:dut_packing_utility/utils/config/app_navigation.dart';
import 'package:dut_packing_utility/utils/services/storage_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StaffController extends BaseController {
  StaffController(this._storageService, this._createCheckInUsecase, this._createCheckOutUsecase);

  final StorageService _storageService;
  final CreateCheckInUsecase _createCheckInUsecase;
  final CreateCheckOutUsecase _createCheckOutUsecase;

  QRViewController? _qrCodecontroller;

  var isChecked = false.obs;

  var isCheckIn = true.obs;

  var isScan = false.obs;

  var confirmState = false.obs;

  var customer = CustomerModel().obs;

  @override
  void onClose() {
    super.onClose();
    _qrCodecontroller?.dispose();
  }

  void onQRViewCreated(QRViewController qrCodecontroller) {
    _qrCodecontroller = qrCodecontroller;
    _qrCodecontroller?.resumeCamera();
    _qrCodecontroller?.pauseCamera();
    _qrCodecontroller?.scannedDataStream.listen(
      (scanData) {
        var result = scanData.code ?? "";
        if (result != "") {
          print(result);
          _qrCodecontroller?.pauseCamera();
          if (isCheckIn.value) {
            try {
              customer.value = CustomerModel.fromJsonWithVehical(jsonDecode(result));
              isChecked.value = true;
            } catch (e) {
              showOkDialog(title: "Mã không hợp lệ", message: "Đây không phải là một mã hợp lệ vui lòng kiểm tra lại");
              pauseScan();
            }
          } else {
            try {
              isChecked.value = true;
            } catch (e) {
              showOkDialog(title: "Mã không hợp lệ", message: "Đây không phải là một mã hợp lệ vui lòng kiểm tra lại");
              pauseScan();
            }
          }
        }
      },
    );
  }

  void resumeScan() {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
  }

  void startScan(bool checkIn) {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
    isScan.value = true;
    isCheckIn.value = checkIn;
  }

  void pauseScan() {
    _qrCodecontroller?.pauseCamera();
    isChecked.value = false;
    isScan.value = false;
    confirmState.value = false;
  }

  void confirmScan() {
    DateTime now = DateTime.now();
    String timeNow = DateFormat('yyyy-MM-ddTHH:mm:ss\'Z\'').format(now);
    if (isCheckIn.value) {
      // check in
    } else {
      // check out
    }
  }

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạnc chắc chắn muôn đăng xuất khỏi hệ thống?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        await _storageService.removeCustomer();
        N.toWelcomePage();
      }
    });
  }
}
