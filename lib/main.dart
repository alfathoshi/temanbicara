import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
// import 'app/modules/chatbot_room/api_key.dart';
import 'app/routes/app_pages.dart';

void main() {
  // Gemini.init(apiKey: googleAPI);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: "Teman Bicara",
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
      ),
    ),
    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Teman Bicara",
    //   initialRoute: Routes.SPLASH_SCREEN,
    //   getPages: AppPages.routes,
    // ),
  );
}
