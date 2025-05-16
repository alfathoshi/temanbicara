import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/transaction/invoice_pdf.dart';
import 'package:temanbicara/app/utils/platform_channel.dart';

class TransactionInvoiceController extends GetxController {
  final isSharing = false.obs;
  final isDownloading = false.obs;

  Future<String> getDownloadPath() async {
    if (Platform.isAndroid) {
      final directory = Directory('/storage/emulated/0/Download');
      if (await directory.exists()) return directory.path;
      final fallback = await getExternalStorageDirectory();
      return fallback?.path ?? '';
    } else {
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
    }
  }

  Future<void> downloadInvoice(InvoiceModel invoice) async {
    try {
      isDownloading.value = true;

      final downloadDir = await getDownloadPath();
      final filePath =
          '$downloadDir/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

      await CreatePDF.generatePDF(invoice, outputPath: filePath);

      Get.snackbar(
        'Success!',
        'Your invoice has been saved to the Download folder.',
        backgroundColor: primaryColor.withOpacity(0.7),
        colorText: whiteColor,
      );
    } catch (e) {
      Get.snackbar(
        'Oops!',
        'Failed to save invoice. Please try again.',
        backgroundColor: error.withOpacity(0.7),
        colorText: whiteColor,
      );
    } finally {
      isDownloading.value = false;
    }
  }

  Future<void> shareInvoice(InvoiceModel invoice) async {
    try {
      isSharing.value = true;

      final downloadDir = await getDownloadPath();
      final filePath =
          '$downloadDir/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final file = await CreatePDF.generatePDF(invoice, outputPath: filePath);

      await NativeShare.shareFile(file.path);
    } catch (e) {
      Get.snackbar(
        'Oops!',
        'Failed to share invoice: $e',
        backgroundColor: error.withOpacity(0.85),
        colorText: whiteColor,
      );
    } finally {
      isSharing.value = false;
    }
  }
}
