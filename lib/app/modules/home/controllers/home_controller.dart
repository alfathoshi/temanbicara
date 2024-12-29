import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;

  Future<Map<String, dynamic>> fetchData() async {
 
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/article'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
       print(response.body);
      throw Exception('Failed to load article');
    }
  }
}

