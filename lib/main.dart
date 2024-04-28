import 'package:camera/camera.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/constants/themes/dark_theme.dart';
import 'package:graviitee/app/constants/themes/light_theme.dart';
import 'package:graviitee/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:graviitee/app/utils/lang/LocalizationService.dart';
import 'package:graviitee/app/utils/logger/logger_utils.dart';
import 'package:graviitee/app/utils/theme/theme_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app/routes/app_pages.dart';
List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(
    ConnectivityAppWrapper(
      app: GetMaterialApp(
        title: "Application",
        initialBinding: SplashScreenBinding(),
        debugShowCheckedModeBanner: false,
        theme: lightThemes(),
        darkTheme: darkThemes(),
        themeMode: ThemeService().theme,
        logWriterCallback: Logger.write,
        translations: LocalizationService(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    ),
  );
}


