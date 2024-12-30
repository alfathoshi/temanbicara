import 'dart:convert';
import 'dart:math';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ChatController extends GetxController {
  final listChat = [].obs;
  GetStorage box = GetStorage();


  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'http://10.0.2.2:8000/api/v1/consultation-user',
      ),
      headers: {'Authorization': 'Bearer ${box.read('token')}'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      listChat.value = data['data'];
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load chat');
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
