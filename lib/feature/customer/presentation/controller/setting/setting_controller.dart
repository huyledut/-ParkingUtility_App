import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/base/presentation/base_widget.dart';
import 'package:dut_packing_utility/utils/config/app_navigation.dart';
import 'package:dut_packing_utility/utils/services/storage_service.dart';

class SettingController extends BaseController {
  SettingController(this._storageService);

  final StorageService _storageService;

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi hệ thống?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        await _storageService.removeCustomer();
        N.toWelcomePage();
      }
    });
  }

  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController oldPasswordTextFieldController = TextEditingController();
  TextEditingController newPasswordTextFieldController = TextEditingController();
  var isShowOldPassword = true.obs;
  var isShowNewPassword = true.obs;
  var isShowConfirmPassword = true.obs;
  var changePasswordState = false.obs;
}
