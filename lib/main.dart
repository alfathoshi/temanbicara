import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/services/notification_api.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   await dotenv.load();
//   Gemini.init(apiKey: dotenv.env['GOOGLE_API']!);
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await FirebaseMessaging.instance.requestPermission();
//   await NotificationService.init();
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     NotificationService.showNotification(message);
//   });
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Teman Bicara",
//       initialRoute: Routes.SPLASH_SCREEN,
//       getPages: AppPages.routes,
//     ),
//   );
// }

void main() {
  bootstrap();
}

// bootstrap.dart
Future<void> bootstrap() async {
  await dotenv.load();
  Gemini.init(apiKey: dotenv.env['GOOGLE_API']!);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  await NotificationService.init();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService.showNotification(message);
  });

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teman Bicara",
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
    ),
  );
}
