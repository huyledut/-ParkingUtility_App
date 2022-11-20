import 'package:dut_packing_utility/utils/services/storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../../../utils/config/app_navigation.dart';

class RootController extends GetxController {
  RootController(this._storageService);
  final StorageService _storageService;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
      FlutterNativeSplash.remove();
      N.toWelcomePage();
    });
    appStart();
  }

  void appStart() {}
}
