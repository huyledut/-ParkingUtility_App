import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_utility/feature/authentication/data/providers/remote/request/username_password_request.dart';
import 'package:dut_packing_utility/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_utility/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_utility/utils/config/app_navigation.dart';
import 'package:dut_packing_utility/utils/extension/form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../base/presentation/base_controller.dart';
import '../../../../../utils/services/storage_service.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends BaseController {
  LoginController(this._loginUsecase, this._storageService, this._getCustomerInfoUsecase);

  final LoginUsecase _loginUsecase;
  final StorageService _storageService;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;

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
      usernameTextEditingController.text = 'nhanvien';
      passwordTextEditingController.text = '123123123';
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
      _loginUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            loginState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            ignoringPointer.value = false;

            _storageService.setToken(account.toJson().toString());

            _getCustomerInfoUsecase.execute(
              observer: Observer(
                onSubscribe: () {},
                onSuccess: (customer) async {
                  print(customer.toJson());
                  await _storageService.setCustomer(customer.toJson().toString());
                  if (customer.name != null &&
                      customer.gender != null &&
                      customer.birthday != null &&
                      customer.phoneNumber != null &&
                      customer.activityClass != null &&
                      customer.facultyId != null) {
                    print("Go to home");
                    if (account.roleId == 30) {
                      N.toHome();
                    } else {
                      N.toStaffPage();
                    }
                  } else {
                    print("Go to profile");
                    if (account.roleId == 30) {
                      N.toProfile();
                    } else {
                      N.toStaffPage();
                    }
                  }
                },
                onError: (e) async {
                  if (e is DioError) {
                    _showToastMessage(e.message);
                  }
                  if (kDebugMode) {
                    print(e.toString());
                  }
                  ignoringPointer.value = false;
                  loginState.onSuccess();
                },
              ),
            );
          },
          onError: (e) {
            if (e is DioError) {
              _showToastMessage(e.message);
            }
            if (kDebugMode) {
              print(e.toString());
            }
            ignoringPointer.value = false;
            loginState.onSuccess();
          },
        ),
        input: UsernamePasswordRequest(
          _username.trim(),
          _password.trim(),
        ),
      );
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
