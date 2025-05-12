import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../config/config.dart';

class ChatController extends GetxController {
  final listChat = [].obs;
  GetStorage box = GetStorage();

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
        "${Config.apiEndPoint}/consultation",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      listChat.value = data['data'];
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chat');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void increment() => count.value++;
}
