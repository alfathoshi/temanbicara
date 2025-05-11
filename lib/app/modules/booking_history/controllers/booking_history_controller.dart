import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:temanbicara/app/data/consultComplete.dart';
import 'package:temanbicara/app/data/consultPending.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:get_storage/get_storage.dart';

class BookingHistoryController extends GetxController {
  var pendingList = <ConsultPending>[].obs;
  var completedList = <ConsultComplete>[].obs;
  var isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    await fetchPending();
    await fetchCompleted();
    isLoading.value = false;
  }

  Future<void> fetchPending() async {
    try {
      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/bookingHistory'),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "payment_status": "Pending",
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          List pendingData = data['data'];
          pendingList.value = pendingData.map((item) {
            final schedule = item['schedule'];
            final payment = item['payment'];
            final amount = payment['amount'];
            final paymentMethod = payment['payment_method'];
            final expiredDate = payment['expired_date'];
            final nama = schedule['user'];
            final bank = payment['bank'];
            final createdAt = payment['created_at'];
            final patientId = item['patient_id'];
            final scheduleId = item['schedule_id'];
            final paymentId = item['payment_id'];

            String expiredTime = '';
            String formattedExpiredDate = '';
            if (expiredDate.isNotEmpty) {
              List<String> parts = expiredDate.split(' ');
              if (parts.length == 2) {
                final datePart = parts[0];
                final timePart = parts[1];

                final parsedDate = DateTime.parse(datePart);
                formattedExpiredDate =
                    "${parsedDate.day} ${_monthName(parsedDate.month)}";
                expiredTime = timePart.substring(0, 5);
              }
            }
            return ConsultPending(
              nama: nama['name'],
              bank: payment['bank'],
              durasi: _calculateDuration(
                  schedule['start_time'], schedule['end_time']),
              tanggal: schedule['available_date'] != null
                  ? _formatFullDate(schedule['available_date'])
                  : '-',
              waktu: _formatTime(schedule['start_time']),
              tanggalTenggat: formattedExpiredDate,
              waktuTenggat: expiredTime,
              metodePembayaran: paymentMethod + " - " + bank,
              totalHarga: amount.toString(),
            );
          }).toList();
        } else {
          pendingList.clear();
        }
      } else {
        //print('Failed to fetch pending, status: ${response.statusCode}');
      }
    } catch (e) {
      //Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchCompleted() async {
    try {
      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/bookingHistory'),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "payment_status": "Completed",
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          completedList.value = (data['data'] as List).map((item) {
            final schedule = item['schedule'];
            return ConsultComplete(
              nama: "Counselor Name", // <- nanti kalau ada nama, ganti ya
              durasi: "${schedule['start_time']} - ${schedule['end_time']}",
              expertise: "Counselor Expertise", // <-- dummy dulu
              tanggal: schedule['available_date'].substring(0, 10),
              waktu: schedule['start_time'],
            );
          }).toList();
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  
  
  String _calculateDuration(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return '-';

    final start = TimeOfDay(
      hour: int.parse(startTime.split(':')[0]),
      minute: int.parse(startTime.split(':')[1]),
    );
    final end = TimeOfDay(
      hour: int.parse(endTime.split(':')[0]),
      minute: int.parse(endTime.split(':')[1]),
    );

    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    final diff = endMinutes - startMinutes;

    return "$diff menit";
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '-';
    final parts = time.split(':');
    if (parts.length >= 2) {
      return "${parts[0]}:${parts[1]}";
    }
    return time;
  }

  String _monthName(int month) {
    const monthNames = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return monthNames[month];
  }

  String _formatFullDate(String dateStr) {
    final parsedDate = DateTime.parse(dateStr);
    return "${parsedDate.day} ${_monthName(parsedDate.month)} ${parsedDate.year}";
  }
}
