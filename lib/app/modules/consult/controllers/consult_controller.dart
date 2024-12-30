import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConsultController extends GetxController {
  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/available-schedule'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
}
