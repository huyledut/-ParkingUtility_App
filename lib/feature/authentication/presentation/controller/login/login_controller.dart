import 'package:dio/dio.dart';
import 'package:dut_packing_utility/utils/extension/form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../base/presentation/base_controller.dart';

class LoginController extends BaseController {
  LoginController();

  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  String get _username => usernameTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      // test user
      usernameTextEditingController.text = 'quylt123';
      passwordTextEditingController.text = '123123';

      // test staff
      usernameTextEditingController.text = 'admin';
      passwordTextEditingController.text = 'Pa\$\$w0rd';
    }
  }

  @override
  void onClose() {
    usernameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _username.isEmpty || _password.isEmpty;
  }

  void onTapLogin(BuildContext context) {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.username.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      [
        phoneField,
        passwordField,
      ].validateFormFields();

      if (loginState.isLoading) return;
      // login feature
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    loginState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
