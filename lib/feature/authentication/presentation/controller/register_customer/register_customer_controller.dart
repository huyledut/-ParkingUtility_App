import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_utility/utils/extension/form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../base/presentation/base_controller.dart';

class RegisterCustomerController extends BaseController {
  RegisterCustomerController();



  final usernameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final registerState = BaseState();

  String get _email => emailTextEditingController.text;
  String get _username => usernameTextEditingController.text;
  String get _password => passwordTextEditingController.text;
  String get _confirmPassword => confirmPasswordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;
  final isShowConfirmPassword = true.obs;

  @override
  void onClose() {
    usernameTextEditingController.dispose();
    emailTextEditingController.dispose();
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
    isDisableButton.value = _username.isEmpty || _password.isEmpty || _confirmPassword.isEmpty || _email.isEmpty;
  }

  void onTapRegister(BuildContext context) {
    try {
      final fbs = formKey.formBuilderState!;
      final userNameField = FormFieldType.username.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      final confirmPassword = FormFieldType.confirmPassword.field(fbs);
      final emailField = FormFieldType.email.field(fbs);
      [
        userNameField,
        emailField,
        passwordField,
        confirmPassword,
      ].validateFormFields();
      if (_password != _confirmPassword) {
        _showToastMessage('Mật khẩu không trùng khớp');
        return;
      }

      if (registerState.isLoading) return;
      // register feature
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
