import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_invoice/views/transaction_invoice_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/transaction/transactionPriceDetail.dart';
import 'package:temanbicara/app/widgets/transaction/transactionRemainingTime.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';
import 'package:temanbicara/app/widgets/transaction/transactionVANumber.dart';

import '../controllers/transaction_payment_controller.dart';

class TransactionPaymentView extends GetView<TransactionPaymentController> {
  final String? paymentMethod;
  TransactionPaymentView({super.key, this.paymentMethod});

  final TransactionPaymentController controller =
      Get.put(TransactionPaymentController());
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userID = box.read('id');
    final TransactionModel transaction = Get.arguments as TransactionModel;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          toolbarHeight: 85,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Trasactions',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              sby24,
              TransactionTimeLineViewIndex(index: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sby5,
                    Text("Payment", style: h5Bold),
                    sby24,
                    TransactionRemainingTime(
                      onTimerEnd: () async {
                        Get.dialog(
                          Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                          barrierDismissible: false,
                        );

                        await Future.delayed(Duration(seconds: 2));

                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/transaksi-gagal.png',
                                  height: 200,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Time's Up!",
                                  style: h4Bold.copyWith(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Your transaction time has expired. \n You will be redirected.",
                                  style: h7Bold,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              Center(
                                child: SizedBox(
                                  width: 205,
                                  height: 42,
                                  child: ElevatedButton(
                                    child: Text('OK',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      Get.offAllNamed(Routes.NAVIGATION_BAR,
                                          arguments: {'indexPage': 0});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          barrierDismissible:
                              false, // Prevent closing without pressing OK
                        );
                      },
                    ),
                    sby24,
                    TransactionVaNumberBorder(
                      vaNumber: '09128120371937',
                    ),
                    sby12,
                    TransactionPriceDetail(
                        invoice: InvoiceModel(
                            transaction: transaction,
                            invoice: "invoice",
                            metodePembayaran: paymentMethod!,
                            hargaTotal: 15000 + 1000 + transaction.harga)),
                    sby24,
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'By processing this transaction, you agree to all the ',
                          style: h7Regular,
                          children: [
                            TextSpan(
                                text: 'Terms and Condition',
                                style: h7Regular.copyWith(color: Colors.blue)),
                            TextSpan(text: ' of'),
                            TextSpan(
                                text: ' Teman Bicara',
                                style: h7Regular.copyWith(color: primaryColor))
                          ],
                        ),
                      ),
                    ),
                    sby48,
                    Padding(
                        padding: const EdgeInsets.only(bottom: 45),
                        child: MyButton(
                            get: () async {
                              Get.dialog(
                                Obx(
                                  () => AlertDialog(
                                    content: controller.isLoading.value
                                        ? Row(
                                            children: [
                                              CircularProgressIndicator(
                                                  color: primaryColor),
                                              sbX24,
                                              Text(
                                                "Loading ...",
                                                style: h4Regular,
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "Berhasil membuat jadwal",
                                            style: h4Regular,
                                          ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                              await controller.createConsultation(
                                scheduleId: transaction.selectedID,
                                patientId: userID,
                                amount: transaction.harga,
                                bank: paymentMethod!,
                              );

                              if (!controller.isLoading.value) {
                                Get.back();
                              }

                              Get.to(
                                TransactionInvoiceView(),
                                arguments: InvoiceModel(
                                  transaction: transaction,
                                  invoice: "invoice",
                                  metodePembayaran: paymentMethod!,
                                  hargaTotal: 15000 + 1000 + transaction.harga,
                                ),
                              );
                            },
                            color: primaryColor,
                            text: "Check Payment Status")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
