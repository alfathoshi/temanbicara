import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_invoice/views/transaction_invoice_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/transactionPriceDetail.dart';
import 'package:temanbicara/app/widgets/transaction/transactionRemainingTime.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

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
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Transaction',
          style: h3Bold,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Get.back();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
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
                  TransactionRemainingTime(),
                  sby24,
                  TransactionPriceDetail(
                      invoice: InvoiceModel(
                          transaction: transaction,
                          invoice: "invoice",
                          appTax: 15000,
                          admTax: 1000,
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
                    child: Center(
                      child: SizedBox(
                        width: 205,
                        height: 42,
                        child: ElevatedButton(
                          child: Text('Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            print(userID);
                            Get.dialog(
                              Obx(() => AlertDialog(
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
                                  )),
                              barrierDismissible: false,
                            );

                            await controller.executeTransaction(
                              transaction.selectedID,
                              userID,
                            );

                            if (!controller.isLoading.value) {
                              Get.back();
                            }

                            Get.to(
                              TransactionInvoiceView(),
                              arguments: InvoiceModel(
                                transaction: transaction,
                                invoice: "invoice",
                                appTax: 15000,
                                admTax: 1000,
                                metodePembayaran: paymentMethod!,
                                hargaTotal: 15000 + 1000 + transaction.harga,
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
