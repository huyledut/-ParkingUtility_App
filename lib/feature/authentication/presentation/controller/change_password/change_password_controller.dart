import 'package:dut_packing_utility/base/presentation/base_controller.dart';
import 'package:dut_packing_utility/base/presentation/base_widget.dart';
import 'package:dut_packing_utility/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_utility/feature/customer/domain/usecases/change_password_usecase.dart';
import 'package:dut_packing_utility/utils/extension/form_builder.dart';
import 'package:dut_packing_utility/utils/gen/colors.gen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  ChangePasswordController(this._changePasswordUsecase);
  final ChangePasswordUsecase _changePasswordUsecase;

  final oldPasswordTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final registerState = BaseState();

  String get _oldPassword => oldPasswordTextEditingController.text;
  String get _password => passwordTextEditingController.text;
  String get _confirmPassword => confirmPasswordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;
  final isShowConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    oldPasswordTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onTapShowConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateRegisterButtonState() {
    isDisableButton.value = _oldPassword.isEmpty || _password.isEmpty || _confirmPassword.isEmpty;
  }

  Future<void> onTapChangePassword() async {
    try {
      final fbs = formKey.formBuilderState!;
      final oldPassword = FormFieldType.oldPassword.field(fbs);
      final passwordField = FormFieldType.newPassword.field(fbs);
      final confirmPassword = FormFieldType.confirmPassword.field(fbs);
      [
        oldPassword,
        passwordField,
        confirmPassword,
      ].validateFormFields();
      if (_password != _confirmPassword) {
        _showToastMessage('Mật khẩu không trùng khớp');
        return;
      }

      if (registerState.isLoading) return;

      _changePasswordUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            registerState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            registerState.onSuccess();
            ignoringPointer.value = false;
            back();
            Get.snackbar(
              "Cập nhật thành công",
              "Mật khẩu của bạn đã được thay đổi",
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              duration: const Duration(seconds: 4),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: ColorName.whiteFaf,
              animationDuration: const Duration(milliseconds: 300),
              boxShadows: [
                const BoxShadow(
                  offset: Offset(-8, -8),
                  blurRadius: 10,
                  color: ColorName.gray838,
                ),
              ],
            );
          },
          onError: (e) async {
            debugPrint(e.toString());
            registerState.onSuccess();
            ignoringPointer.value = false;
          },
        ),
        input: ChangePasswordRequest(
          _oldPassword.trim(),
          _password.trim(),
          _confirmPassword.trim(),
        ),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    registerState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
