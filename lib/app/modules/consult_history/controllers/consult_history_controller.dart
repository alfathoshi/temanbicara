import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConsultHistoryController extends GetxController {
  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/schedule'));
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule');
    }
  }
}
