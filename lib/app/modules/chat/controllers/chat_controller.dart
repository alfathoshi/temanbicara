import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
import '../../../config/config.dart';
import '../../../services/chat_services.dart';

class ChatController extends GetxController {
  final listChat = <Map<String, dynamic>>[].obs;
  GetStorage box = GetStorage();
  var isLoading = true.obs;
  final ChatService _chatService = ChatService();
  String get currentUserId => box.read('id').toString();

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("${Config.apiEndPoint}/consultation/user"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true &&
            data['data'] != null &&
            data['data'] is List) {
          final List rawData = data['data'];
          final List<Map<String, dynamic>> uniqueCounselorList =
              rawData.fold<List<Map<String, dynamic>>>([], (acc, item) {
            if (acc.indexWhere((element) =>
                    element['counselor_id'].toString() ==
                    item['counselor_id'].toString()) ==
                -1) {
              acc.add(item as Map<String, dynamic>);
            }
            return acc;
          });
          listChat.value = uniqueCounselorList;
        } else {
          listChat.clear();
          CustomSnackbar.showSnackbar(
            title: "Oops!",
            message: "No Chat Found!",
            status: false,
          );
        }
      } else {
        listChat.clear();
        throw Exception('Failed to load chat list: ${response.reasonPhrase}');
      }
    } catch (e) {
      listChat.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot> getLastMessageStream(String counselorId) {
    return _chatService.getMessages(currentUserId, counselorId);
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    if (DateTime.now().difference(dateTime).inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd MMM').format(dateTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}
