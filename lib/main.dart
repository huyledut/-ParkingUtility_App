import 'package:dut_packing_utility/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_cupertino_app.dart';
import 'package:get/route_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'main.reflectable.dart';
import 'utils/config/app_binding.dart';
import 'utils/config/app_route.dart';

void main() async {
  _initApp();
  initializeReflectable();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://9a2e72f02c804bed943cdeba916ef8e4@o4504259552477184.ingest.sentry.io/4504277063172096';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(primaryColor: ColorName.whiteFff),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: AppBinding(),
      getPages: AppRoute.generateGetPages,
      initialRoute: AppRoute.root,
    );
  }
}

void _initApp() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}
