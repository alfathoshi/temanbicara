// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/transaction/invoiceData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceView extends GetView<TransactionInvoiceController> {
  const TransactionInvoiceView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    final data = Get.arguments as Map;
    final InvoiceModel invoice = data['invoice'];
    final TransactionModel transaction = data['transaction'];
    final consultationData = data['consultationData'];

    return PopScope(
      canPop: false,
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
              Container(
                height: 60,
                child: Expanded(
                  child: TransactionTimeLineViewIndex(index: 4),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sby5,
                      Text("Invoice", style: h4Bold),
                      sby24,
                      InvoiceData(invoice: invoice),
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
                                "Share Invoice",
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
                      sby48,
                      MyButton(
                        color: primaryColor,
                        text: 'Done',
                        get: () {
                          Get.offAllNamed(
                            Routes.NAVIGATION_BAR,
                            arguments: {"indexPage": 0},
                          );
                        },
                      ),
                      sby36,
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
