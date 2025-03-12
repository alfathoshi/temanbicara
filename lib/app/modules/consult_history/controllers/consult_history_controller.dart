import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ConsultHistoryController extends GetxController {
  final box = GetStorage();

  Future<Map<String, dynamic>> fetchData() async {
    final token = box.read('token');
    final response = await http.get(
        Uri.parse('http://103.161.185.183:8000/api/v1/available-schedule'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load history');
    }
  }
}
