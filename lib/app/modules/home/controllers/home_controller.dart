import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;

  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/article'));
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule');
    }
  }
  // var articleList = [].obs;
  // Future<void> fetchArticles() async {
  //   isLoading.value = true;
  //   try {
  //     final userId = box.read('id');
  //     final artikelID = box.write('artikel,id', 'artikel_id');
  //     print("ppk ${userId}");
  //     final token = box.read('token');
  //     print("token  ${token}");
  //     var response = await http.get(
  //       Uri.parse('http://10.0.2.2:8000/api/v1/article'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       print(data);
  //       if (data['status']) {
  //         articleList.value = data['data'];
  //       } else {
  //         print(data['message']);
  //         Get.snackbar('Error', data['message']);
  //       }
  //     } else {
  //       print("Response Body: ${response.body}");

  //       Get.snackbar('Error', '${response.body}');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Something went wrong: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onClose() {}
}
