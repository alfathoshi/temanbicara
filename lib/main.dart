import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'app/modules/chatbot_room/api_key.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  Gemini.init(apiKey: googleAPI);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     useInheritedMediaQuery: true,
    //     locale: DevicePreview.locale(context),
    //     builder: DevicePreview.appBuilder,
    //     theme: ThemeData.light(),
    //     darkTheme: ThemeData.dark(),
    //     title: "Teman Bicara",
    //     initialRoute: Routes.SPLASH_SCREEN,
    //     getPages: AppPages.routes,
    //   ),
    // ),
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teman Bicara",
      initialRoute: Routes.NEW_TRACKING,
      getPages: AppPages.routes,
    ),
  );
}
