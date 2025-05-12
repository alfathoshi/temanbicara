import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart' show rootBundle;

class FCMService {
  static const _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  static Future<void> sendPushMessage({
    required String targetToken,
    required String title,
    required String body,
  }) async {
    final serviceAccountJson =
        await rootBundle.loadString('assets/firebase/service-account.json');
    final serviceAccount =
        ServiceAccountCredentials.fromJson(serviceAccountJson);
    final projectId = jsonDecode(serviceAccountJson)['project_id'];

    final authClient = await clientViaServiceAccount(serviceAccount, _scopes);

    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    // ignore: unused_local_variable
    final response = await authClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': {
          'token': targetToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'title': title,
            'body': body,
          },
        },
      }),
    );
  }
}
