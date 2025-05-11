import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';

class TransactionPaymentController extends GetxController {
  final box = GetStorage();
  Timer? _statusChecker;

  void startAutoCheck(String uuid) {
    _statusChecker?.cancel();

    _statusChecker = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final success = await checkPaymentStatus(uuid);
      if (success) {
        timer.cancel();
      }
    });
  }

  void stopAutoCheck() {
    _statusChecker?.cancel();
  }

  Future<bool> checkPaymentStatus(String uuid) async {
    try {
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/payment/$uuid'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final status = jsonResponse['transaction_status'];

        if (status == 'settlement') {
          return true;
        } else {
          print("Status: $status");
        }
      }
    } catch (e) {
      print("Error checking payment status: $e");
    }
    return false;
  }

  @override
  void onClose() {
    stopAutoCheck();
    super.onClose();
  }
}
