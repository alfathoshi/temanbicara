import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/data/consult_data.dart';
import 'package:temanbicara/app/widgets/consult/format_full_date.dart';
import 'package:temanbicara/app/widgets/consult/format_time.dart';
import 'package:temanbicara/app/widgets/consult/history_calculate_duration.dart';

import '../../../config/config.dart';

class ConsultHistoryController extends GetxController {
  final consultList = <ConsultHistory>[].obs;
  final isLoading = false.obs;
  final box = GetStorage();

  Future<void> fetchData() async {
    isLoading(true);
    await fetchHistory();
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchHistory() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/consultation/user'),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final list = data['data'] as List;

          final filtered = list.where((e) => e['status'] != 'Cancelled');
          consultList.value = filtered.map(_mapToConsultModel).toList();
        }
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  ConsultHistory _mapToConsultModel(dynamic item) {
    final status = item['status'] ?? '-';
    final name = item['counselor_name'] ?? '-';
    final counselorId = (item['counselor_id'] ?? '').toString();
    final startTime = item['start_time'] ?? '-';
    final endTime = item['end_time'] ?? '-';
    final rawDate = item['date'] ?? '';

    final durasi = calculateDuration(startTime, endTime);
    final tanggal = formatFullDate(rawDate);

    return ConsultHistory(
      status: status,
      nama: name,
      counselorId: counselorId,
      tanggal: tanggal,
      waktuMulai: formatTime(startTime),
      waktuSelesai: formatTime(endTime),
      durasi: durasi,
      problem: item['problem'],
      summary: item['summary'],
      description: item['description'],
    );
  }
}
