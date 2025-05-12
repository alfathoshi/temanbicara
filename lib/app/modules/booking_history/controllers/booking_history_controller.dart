import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/data/consultComplete.dart';
import 'package:temanbicara/app/data/consultPending.dart';
import 'package:temanbicara/app/data/consultResponse.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

class BookingHistoryController extends GetxController {
  final pendingList = <ConsultPending>[].obs;
  final completedList = <ConsultComplete>[].obs;
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading(true);
    await Future.wait([fetchHistory("Pending"), fetchHistory("Success")]);
    isLoading(false);
  }

  Future<void> checkPaymentStatus(String uuid) async {
    final token = box.read('token');

    try {
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/payment/$uuid'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final status = json.decode(response.body)['transaction_status'];
        if (status == 'settlement') {
          final matched = pendingList.firstWhereOrNull(
            (e) => e.transactionId == uuid,
          );

          if (matched != null) {
            final transaction = TransactionModel(
              namaPsikiater: matched.nama,
              expertise: "Counselor Expertise",
              jadwal: matched.availableDateRaw!,
              waktu: matched.waktu,
              selectedID: matched.scheduleId,
            );

            final invoice = InvoiceModel(
              transaction: transaction,
              invoice: "INV-${matched.paymentId}",
              metodePembayaran: matched.metodePembayaran,
              hargaTotal: int.parse(matched.totalHarga) + 15000 + 1000,
            );

            final consultationData = ConsultationResponse(
              bank: matched.bank,
              vaNumber: matched.vaNumber,
              paymentMethod: matched.metodePembayaran,
              transactionId: matched.transactionId,
              expiredDate: matched.expiredDate,
              amount: int.parse(matched.totalHarga),
            );

            Get.snackbar(
              'Success',
              'Your payment has been confirmed!',
              backgroundColor: primaryColor.withOpacity(0.6),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );

            Get.offAllNamed(Routes.TRANSACTION_SUCCESS, arguments: {
              'consultationData': consultationData,
              'transaction': transaction,
              'invoice': invoice,
            });
          }
        }
      }
    } catch (e) {
      print('Error checking payment status: $e');
    }
  }

  Future<void> fetchHistory(String status) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/bookingHistory'),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"payment_status": status}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final list = data['data'] as List;
          if (status == "Pending") {
            pendingList.value = list.map(_mapPending).toList();
          } else {
            completedList.value = list.map(_mapCompleted).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  ConsultPending _mapPending(dynamic item) {
    final schedule = item['schedule'];
    final payment = item['payment'];
    final expired = _parseExpiredDate(payment['expired_date']);
    final user = schedule['user'];
    final expertiseList = user['expertises'] as List;
    final expertise = expertiseList.isNotEmpty ? expertiseList[0] : null;

    return ConsultPending(
      nama: schedule['user']['name'],
      bank: payment['bank'],
      durasi: _calculateDuration(schedule['start_time'], schedule['end_time']),
      tanggal: _formatFullDate(schedule['available_date']),
      waktu: _formatTime(schedule['start_time']),
      tanggalTenggat: expired['date']!,
      waktuTenggat: expired['time']!,
      metodePembayaran: "${payment['payment_method']} - ${payment['bank']}",
      totalHarga: payment['amount'].toString(),
      vaNumber: (payment['va_number'] ?? '').toString(),
      transactionId: (payment['transaction_id'] ?? '').toString(),
      expiredDate: payment['expired_date'] ?? '',
      availableDateRaw: schedule['available_date'] ?? '',
      expertises: expertise != null ? expertise['type'] : '-',
    );
  }

  ConsultComplete _mapCompleted(dynamic item) {
    final schedule = item['schedule'];
    final payment = item['payment'];
    final user = schedule['user'];
    final expertiseList = user['expertises'] as List;
    final expertise = expertiseList.isNotEmpty ? expertiseList[0] : null;

    return ConsultComplete(
      nama: user['name'],
      durasi: "${schedule['start_time']} - ${schedule['end_time']}",
      expertise: expertise != null ? expertise['type'] : '-',
      tanggal: schedule['available_date'].substring(0, 10),
      waktu: schedule['start_time'],
    );
  }

  Map<String, String> _parseExpiredDate(String expiredDate) {
    if (expiredDate.isEmpty) return {"date": "-", "time": "-"};
    final parts = expiredDate.split(' ');
    if (parts.length != 2) return {"date": "-", "time": "-"};
    final parsedDate = DateTime.parse(parts[0]);
    return {
      "date": "${parsedDate.day} ${_monthName(parsedDate.month)}",
      "time": parts[1].substring(0, 5)
    };
  }

  String _calculateDuration(String? start, String? end) {
    if (start == null || end == null) return '-';
    final s = TimeOfDay(
        hour: int.parse(start.split(':')[0]),
        minute: int.parse(start.split(':')[1]));
    final e = TimeOfDay(
        hour: int.parse(end.split(':')[0]),
        minute: int.parse(end.split(':')[1]));
    return "${(e.hour * 60 + e.minute) - (s.hour * 60 + s.minute)} menit";
  }

  String _formatTime(String? time) =>
      (time?.split(':').take(2).join(':')) ?? '-';

  String _formatFullDate(String date) {
    final parsed = DateTime.parse(date);
    return "${parsed.day} ${_monthName(parsed.month)} ${parsed.year}";
  }

  String _monthName(int month) {
    const names = [
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
      'Desember'
    ];
    return names[month];
  }
}
