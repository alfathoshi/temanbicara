import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

import '../../../config/config.dart';

class Tracking4Controller extends GetxController {
  final box = GetStorage();

  Future<void> storedTracking() async {
    try {
      final userId = box.read('id');
      final token = box.read('token');

      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/do-tracking'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'sleep_quality': box.read('sleep_quality'),
          'mood_level': box.read('mood_level').toString(),
          'stress_level': box.read('stress_level'),
          'user_id': userId,
        }),
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status']) {
        CustomSnackbar.showSnackbar(
          title: "Success!",
          message: "Assessment Finished!",
          status: true,
        );

        Get.offAllNamed(
          Routes.NAVIGATION_BAR,
          arguments: {"indexPage": 0},
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
