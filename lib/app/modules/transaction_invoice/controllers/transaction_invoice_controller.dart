import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
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

      CustomSnackbar.showSnackbar(
        title: "Downloaded!",
        message: "Check your Download Folder!",
        status: true,
      );
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Failed to Save Invoice!",
        status: false,
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
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Failed to Share Invoice!",
        status: false,
      );
    } finally {
      isSharing.value = false;
    }
  }
}
