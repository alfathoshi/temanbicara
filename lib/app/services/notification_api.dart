import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await _localNotif.initialize(initSettings);

    // Buat channel notifikasi untuk Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'chat_channel', // ID channel
      'Chat Notification', // Nama channel
      description: 'Channel untuk notifikasi pesan', // Deskripsi channel
      importance: Importance.high, // Menentukan tingkat kepentingan
    );

    // Buat channel jika belum ada
    await _localNotif
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const String replyKey = 'key_reply';

    // Konfigurasi input untuk tombol reply
    const AndroidNotificationActionInput replyInput =
        AndroidNotificationActionInput(
          allowFreeFormInput: true
        );

    // Konfigurasi AndroidNotificationAction dengan input
    const AndroidNotificationAction action = AndroidNotificationAction(
      'reply_action',
      'Reply',
      inputs: [replyInput],
    );

     AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      'chat_channel',
      'Chat Notification',
      channelDescription: 'Channel buat notif pesan',
      importance: Importance.max,
      priority: Priority.high,
      actions: [action],
    );

     NotificationDetails notifDetails =
        NotificationDetails(android: androidDetails);

    await _localNotif.show(
      message.notification.hashCode,
      message.notification?.title ?? 'New Message',
      message.notification?.body ?? '',
      notifDetails,
    );
  }
}
