import 'package:get/get.dart';

class RoomChatController extends GetxController {
  //TODO: Implement RoomChatController
  final RxList<Map<String, dynamic>> dataChat = <Map<String, dynamic>>[].obs;

  Future<void> fetchChatForUser(String username) async {
    // Simulasikan pengambilan data
    List<Map<String, dynamic>> fetchedData = [
      {"messages": "Pesan baru dari $username"}
    ];

    dataChat.addAll(fetchedData);

    // Debug log untuk memastikan data terupdate
    print("Data chat diperbarui: $dataChat");
  }

  final count = 0.obs;

  void increment() => count.value++;
}
