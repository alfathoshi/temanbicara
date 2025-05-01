import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMService {
  static const _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  static Future<void> sendPushMessage({
    required String targetToken,
    required String title,
    required String body,
  }) async {
    final serviceAccountJson =
        File('assets/service-account.json').readAsStringSync();
    final serviceAccount =
        ServiceAccountCredentials.fromJson(serviceAccountJson);
    final projectId = jsonDecode(serviceAccountJson)['project_id'];

    final authClient = await clientViaServiceAccount(serviceAccount, _scopes);

    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

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
          },
        },
      }),
    );

    print('FCM response: ${response.statusCode}');
    print('FCM body: ${response.body}');
  }
}
