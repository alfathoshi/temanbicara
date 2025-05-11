import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../config/config.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

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

  void increment() => count.value++;
}
