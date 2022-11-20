import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../../../feature/authentication/data/repositories_imp/user_repo_impl.dart';
import '../../../feature/authentication/domain/repositoties/user_repo.dart';
import '../../base/data/remote/builder/dio_builder.dart';
import '../../feature/authentication/data/providers/remote/user_api.dart';
import '../services/storage_service.dart';
import '../services/storage_service_impl.dart';
import 'app_config.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectNetworkProvider();
    injectRepository();
    injectService();
  }

  void injectNetworkProvider() {
    Get.lazyPut(
      () => DioBuilder(
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UserAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
  }

  void injectRepository() {
    Get.put<UserRepo>(UserRepoImpl());
  }

  void injectService() {
    Get.put<StorageService>(StorageServiceImpl());
  }
}
