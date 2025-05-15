import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/transaction/invoice_pdf.dart';

class TransactionInvoiceController extends GetxController {
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
      final downloadDir = await getDownloadPath();
      final filePath =
          '$downloadDir/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

      await CreatePDF.generatePDF(invoice, outputPath: filePath);

      Get.snackbar(
        'Success!',
        'Your invoice has been saved to the Download folder.',
        backgroundColor: primaryColor.withValues(alpha: 0.7),
        colorText: whiteColor,
      );
    } catch (e) {
      Get.snackbar(
        'Oops!',
        'Failed to save invoice. Please try again.',
        backgroundColor: error.withValues(alpha: 0.7),
        colorText: whiteColor,
      );
    }
  }
}
