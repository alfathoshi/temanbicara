import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/main.dart';

class NotificationAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print("token:  $token");

    initPushedNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    Get.toNamed(Routes.HOME);
  }

  Future initPushedNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
