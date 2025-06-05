import 'package:get/get.dart';

import '../../../widgets/consult/format_date.dart';

class JournalDetailController extends GetxController {
  final RxString journalId = ''.obs;
  final RxString title = ''.obs;
  final RxString body = ''.obs;
  final RxString imageUrl = ''.obs;
  final RxString createdAtRaw =
      ''.obs; // Menyimpan string tanggal mentah dari argumen
  final RxString displayDate =
      ''.obs; // Tanggal yang sudah diformat untuk ditampilkan di AppBar

  // Fungsi format tanggal, bisa disesuaikan formatnya
  // Mengikuti contoh dari JournalController, namun formatnya disesuaikan untuk tampilan
  String _formatDateForDisplay(DateTime dateTime) {
    // Menggunakan format yang lebih ramah pengguna untuk tampilan di AppBar
    // Contoh: "28 Mei 2023, 15:30"
    // 'id_ID' untuk lokalisasi Indonesia, pastikan sudah di-setup di main.dart jika perlu
    // Intl.defaultLocale = 'id_ID';
    return formatDate(dateTime);
  }

  // Metode untuk menginisialisasi data dari argumen
  void _processArguments() {
    final arguments = Get.arguments as Map<String, dynamic>?; // Ambil argumen

    if (arguments != null) {
      journalId.value = arguments['journal_id']?.toString() ?? '';
      title.value = arguments['title']?.toString() ?? 'Titile not found';
      body.value =
          arguments['body']?.toString() ?? 'Content not found';
      imageUrl.value = arguments['image_url']?.toString() ?? '';
      createdAtRaw.value = arguments['created_at']?.toString() ?? '';

      if (createdAtRaw.value.isNotEmpty) {
        try {
          DateTime parsedDate = DateTime.parse(createdAtRaw.value);
          displayDate.value = _formatDateForDisplay(parsedDate);
        } catch (e) {
          displayDate.value = 'Format Tanggal Salah';
          // print('Error parsing date in ViewJournalController: $e. Raw date: ${createdAtRaw.value}');
        }
      } else {
        displayDate.value = 'No date';
      }
    } else {
      // Jika tidak ada argumen, set nilai default atau tampilkan error
      title.value = 'Error to load journal';
      body.value = 'Can not load journal';
      displayDate.value = '';
      // Mungkin perlu navigasi kembali atau menampilkan pesan error yang lebih jelas di UI
    }
  }

  @override
  void onInit() {
    super.onInit();
    _processArguments(); // Panggil metode untuk memproses argumen saat controller diinisialisasi
  }
}
