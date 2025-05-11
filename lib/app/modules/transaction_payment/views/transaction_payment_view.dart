import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
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

  @override
  final TransactionPaymentController controller =
      Get.put(TransactionPaymentController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userID = box.read('id');
    final data = Get.arguments as Map;
    final TransactionModel transaction = data["transaction"];
    final consultationData = data["data"];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startAutoCheck(consultationData['transaction_id']);
    });

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.stopAutoCheck();
        }
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: whiteColor,
          title: Text(
            'Transaction',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              sby24,
              const TransactionTimeLineViewIndex(index: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
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

                        await Future.delayed(const Duration(seconds: 2));

                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/transaksi-gagal.png',
                                  height: 200,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Time's Up!",
                                  style: h4Bold.copyWith(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
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
                                    onPressed: () {
                                      Get.offAllNamed(Routes.NAVIGATION_BAR,
                                          arguments: {'indexPage': 0});
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              primaryColor),
                                    ),
                                    child: Text('OK',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
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
                      vaNumber: consultationData['va_number'],
                    ),
                    sby12,
                    TransactionPriceDetail(
                      invoice: InvoiceModel(
                        transaction: transaction,
                        invoice: "invoice",
                        metodePembayaran: paymentMethod!,
                        hargaTotal: transaction.appTax +
                            transaction.admTax +
                            transaction.harga,
                      ),
                    ),
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
                            const TextSpan(text: ' of'),
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
                        get: () {
                          Get.offAllNamed(
                            Routes.NAVIGATION_BAR,
                            arguments: {
                              'indexPage': 0,
                            },
                          );
                        },
                        color: primaryColor,
                        text: "Home",
                      ),
                    ),
                    sby48,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 45),
                      child: MyButton(
                        get: () async {
                          final uuid = consultationData['transaction_id'];
                          final isSuccess =
                              await controller.checkPaymentStatus(uuid);

                          if (isSuccess) {
                            Get.dialog(
                              Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor)),
                              barrierDismissible: false,
                            );

                            await Future.delayed(const Duration(seconds: 2));
                            Get.back();

                            Get.offAllNamed(
                              Routes.TRANSACTION_SUCCESS,
                              arguments: {
                                'consultationData': consultationData,
                                'transaction': transaction,
                                'invoice': InvoiceModel(
                                  transaction: transaction,
                                  invoice: "dummy",
                                  metodePembayaran: "Bank Transfer",
                                  hargaTotal: transaction.admTax +
                                      transaction.appTax +
                                      transaction.harga,
                                ),
                              },
                            );
                          } else {
                            Get.snackbar(
                                "Not Paid", "Transaction belum dibayar.");
                          }
                        },
                        color: primaryColor,
                        text: "Check Payment Status",
                      ),
                    ),
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
