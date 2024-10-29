// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/invoiceData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimeline.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceView extends GetView<TransactionInvoiceController> {
  const TransactionInvoiceView({super.key});
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TransactionTimeLineViewIndex(index: 4),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text("Invoice", style: h4Bold),
                    SizedBox(height: 19),
                    InvoiceData(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Image.asset('assets/images/shareInvoice.png'),
                            SizedBox(width: 5),
                            Text(
                              "Share Video",
                              style: h6SemiBold.copyWith(color: primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/downloadInvoice.png'),
                            SizedBox(width: 5),
                            Text(
                              "Download Invoice",
                              style: h6SemiBold.copyWith(color: primaryColor),
                            ),
                            SizedBox(width: 10),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
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
                    SizedBox(height: 40),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
