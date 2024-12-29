import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final listChat = [].obs;

  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/article'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      listChat.value = data['data'];
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load article');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    print(listChat);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
