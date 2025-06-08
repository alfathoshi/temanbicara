import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/services/chat_services.dart';

enum ChatStatus { loading, notStarted, active, ended }

class ChatRoomController extends GetxController {
  final box = GetStorage();
  final args = Get.arguments;

  var user = const types.User(id: '');
  var otherUser = const types.User(id: '');

  final messageC = TextEditingController();

  final ChatService chatService = ChatService();
  var canSendMessage = false.obs;

  late DateTime startTime;
  late DateTime endTime;
  final chatStatus = ChatStatus.loading.obs;
  Timer? _timer;

  Future<void> handleSendPressed(String message) async {
    if (message.trim().isNotEmpty && chatStatus.value == ChatStatus.active) {
      await chatService.sendMessage(otherUser.id, message);
      canSendMessage.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    user = types.User(
      id: box.read('id').toString(),
      firstName: box.read('nickname'),
    );
    otherUser = types.User(
      id: args['counselor_id'].toString(),
      firstName: args['name'],
    );
    // Ambil string waktu yang sudah lengkap dari arguments
    final startTimeString = args['start_time'] as String? ?? '';
    final endTimeString = args['end_time'] as String? ?? '';

    // Cek jika stringnya valid sebelum di-parse
    if (startTimeString.isNotEmpty && endTimeString.isNotEmpty) {
      try {
        startTime = DateTime.parse(startTimeString);
        endTime = DateTime.parse(endTimeString);

        // Cek statusnya secara berkala (tiap detik)
        _checkChatStatus();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          _checkChatStatus();
        });
      } catch (e) {
        // Kalo gagal parsing (walaupun udah difilter, buat jaga-jaga)
        print("Error parsing date in controller: $e");
        chatStatus.value = ChatStatus.ended; // Anggap sesi berakhir
      }
    } else {
      // Kalo data waktu nggak lengkap, langsung set statusnya berakhir
      print("Incomplete time data received. Session set to ended.");
      chatStatus.value = ChatStatus.ended;
    }
  }

  void _checkChatStatus() {
    final now = DateTime.now();
    if (now.isBefore(startTime)) {
      chatStatus.value = ChatStatus.notStarted;
    } else if (now.isAfter(endTime)) {
      chatStatus.value = ChatStatus.ended;
      _timer?.cancel(); // Kalo udah kelar, stop timer biar hemat resource
    } else {
      chatStatus.value = ChatStatus.active;
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // PENTING: matiin timer pas controller ditutup
    messageC.dispose();
    super.onClose();
  }
}
