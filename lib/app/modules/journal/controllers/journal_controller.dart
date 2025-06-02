import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../config/config.dart';
import '../../../widgets/custom_snackbar.dart';

class JournalController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journalList = [].obs;

  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  Future<void> fetchJournals() async {
    isLoading.value = true;
    journalList.clear();
    try {
      final userId = box.read('id');

      final token = box.read('token');
      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/journal/get')
            .replace(queryParameters: {
          'id': userId.toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'date_request': DateFormat('yyyy-MM-dd').format(selectedDate.value)
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          journalList.value = data['data'];
        }
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJournal(int journalId) async {
    try {
      final token = box.read('token');

      var response = await http.delete(
        Uri.parse('${Config.apiEndPoint}/journal/$journalId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          CustomSnackbar.showSnackbar(
              context: Get.context!,
              title: 'Deleted!',
              message: 'Journal Deleted',
              status: true);
          journalList
              .removeWhere((journal) => journal['journal_id'] == journalId);
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: "Oops!",
          message: "No Journal Deleted!",
          status: false,
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchJournals();
  }
}
