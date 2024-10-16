import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/transactionPriceDetail.dart';
import 'package:temanbicara/app/widgets/transaction/transactionRemainingTime.dart';

import '../controllers/transaction_payment_controller.dart';

class TransactionPaymentView extends GetView<TransactionPaymentController> {
  const TransactionPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Anggap ini progress bar ya blud", style: h4Bold),
            SizedBox(height: 30),
            Text("Payment", style: h5Bold),
            SizedBox(height: 22),
            TransactionRemainingTime(),
            SizedBox(height: 22),
            TransactionPriceDetail(
                invoice: "dummy",
                paymentMethod: "dummy",
                price: 321670,
                appTax: 15000,
                admTax: 1000),
            SizedBox(height: 17),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By processing this transaction, you agree to all the ',
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
            Spacer(),
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
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
