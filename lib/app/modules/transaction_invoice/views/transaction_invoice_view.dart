// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/invoiceData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceView extends GetView<TransactionInvoiceController> {
  const TransactionInvoiceView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    final InvoiceModel invoice = Get.arguments as InvoiceModel;
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
      body: Column(
        children: [
          sby24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TransactionTimeLineViewIndex(index: 4),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sby5,
                  Text("Invoice", style: h4Bold),
                  sby24,
                  // data invoice disini
                  Container(
                      height: screenHeight * 0.58,
                      child: SingleChildScrollView(
                          child: InvoiceData(invoice: invoice))),
                  sby16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          sbx5,
                          Image.asset('assets/images/shareInvoice.png'),
                          sbx5,
                          Text(
                            "Share Video",
                            style: h6SemiBold.copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/downloadInvoice.png'),
                          sbx5,
                          Text(
                            "Download Invoice",
                            style: h6SemiBold.copyWith(color: primaryColor),
                          ),
                          sbX12,
                        ],
                      )
                    ],
                  ),
                  sby16,
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
                        onPressed: () {
                          Get.offAllNamed(
                            Routes.NAVIGATION_BAR,
                            arguments: {"indexPage": 0},
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(primaryColor),
                        ),
                      ),
                    ),
                  ),
                  sby36,
                ],
              ))
        ],
      ),
    );
  }
}
