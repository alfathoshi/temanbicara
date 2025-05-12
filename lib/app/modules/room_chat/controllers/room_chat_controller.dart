import 'package:get/get.dart';

class RoomChatController extends GetxController {
  final RxList<Map<String, dynamic>> dataChat = <Map<String, dynamic>>[].obs;

  Future<void> fetchChatForUser(String username) async {
    // Simulasikan pengambilan data
    List<Map<String, dynamic>> fetchedData = [
      {"messages": "Pesan baru dari $username"}
    ];

    dataChat.addAll(fetchedData);
  }

  final count = 0.obs;

  void increment() => count.value++;
}
