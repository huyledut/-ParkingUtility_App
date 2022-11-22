import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/base/presentation/base_widget.dart';

class SettingController extends BaseController {
  SettingController();


  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController oldPasswordTextFieldController = TextEditingController();
  TextEditingController newPasswordTextFieldController = TextEditingController();
  var isShowOldPassword = true.obs;
  var isShowNewPassword = true.obs;
  var isShowConfirmPassword = true.obs;
  var changePasswordState = false.obs;

 
}
