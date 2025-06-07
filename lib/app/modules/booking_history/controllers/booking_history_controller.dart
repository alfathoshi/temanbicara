import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/data/booking_complete.dart';
import 'package:temanbicara/app/data/booking_pending.dart';
import 'package:temanbicara/app/data/consult_response.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';
import 'package:temanbicara/app/widgets/consult/format_expired_date.dart';
import 'package:temanbicara/app/widgets/consult/format_full_date.dart';
import 'package:temanbicara/app/widgets/consult/format_time.dart';
import 'package:temanbicara/app/widgets/consult/history_calculate_duration.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class BookingHistoryController extends GetxController {
  final pendingList = <BookingPending>[].obs;
  final completedList = <BookingComplete>[].obs;
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
              expertise: matched.expertises,
              jadwal: matched.availableDateRaw!,
              waktu: "${matched.waktuMulai} - ${matched.waktuSelesai}",
              selectedID: matched.scheduleId,
              durasi: calculateDuration(
                matched.waktuMulai,
                matched.waktuSelesai,
              ),
              profileUrl: matched.profileUrl,
            );

            final invoice = InvoiceModel(
              transaction: transaction,
              invoice:
                  "INV-${transaction.selectedID}-${convertDateToDDMMYYYY(transaction.jadwal)}",
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

            CustomSnackbar.showSnackbar(
              title: "All Done!",
              message: "Payment Confirmed!",
              status: true,
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
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Payment Status Checking Failed!",
        status: false,
      );
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
      isLoading.value = false;
    }
  }

  BookingPending _mapPending(dynamic item) {
    final schedule = item['schedule'];
    final payment = item['payment'];
    final expired = parseExpiredDate(payment['expired_date']);
    final user = schedule['user'];
    final expertiseList = user['expertises'] as List;
    final expertise = expertiseList.isNotEmpty ? expertiseList[0] : null;

    return BookingPending(
      nama: schedule['user']['name'],
      bank: payment['bank'],
      durasi: calculateDuration(schedule['start_time'], schedule['end_time']),
      tanggal: formatFullDate(schedule['available_date']),
      waktuMulai: formatTime(schedule['start_time']),
      waktuSelesai: formatTime(schedule['end_time']),
      tanggalTenggat: expired['date']!,
      waktuTenggat: expired['time']!,
      metodePembayaran: "${payment['payment_method']} - ${payment['bank']}",
      totalHarga: payment['amount'].toString(),
      vaNumber: (payment['va_number'] ?? '').toString(),
      transactionId: (payment['transaction_id'] ?? '').toString(),
      expiredDate: payment['expired_date'] ?? '',
      availableDateRaw: schedule['available_date'] ?? '',
      expertises: expertise != null ? expertise['type'] : 'None',
      consultationID: item['consultation_id'],
      profileUrl: user['profile_url'],
    );
  }

  BookingComplete _mapCompleted(dynamic item) {
    final schedule = item['schedule'];
    final payment = item['payment'];
    final user = schedule['user'];
    final expertiseList = user['expertises'] as List;
    final expertise = expertiseList.isNotEmpty ? expertiseList[0] : null;

    return BookingComplete(
      invoice: 'invoice',
      transaction: TransactionModel(
        namaPsikiater: user['name'],
        expertise: expertise != null ? expertise['type'] : 'None',
        durasi: calculateDuration(schedule['start_time'], schedule['end_time']),
        jadwal: formatFullDate(schedule['available_date']),
        waktu:
            "${formatTime(schedule['start_time'])} - ${formatTime(schedule['end_time'])}",
        selectedID: item['schedule_id'],
        profileUrl: user['profile_url'],
      ),
      bookingDate: formatFullDate(item['created_at']),
      metode: payment['payment_method'] ?? '-',
      profileUrl: user['profile_url'],
    );
  }
}
