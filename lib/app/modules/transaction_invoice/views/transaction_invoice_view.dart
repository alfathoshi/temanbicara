// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimeline.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceView extends GetView<TransactionInvoiceController> {
  const TransactionInvoiceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionInvoiceView'),
        centerTitle: true,
      ),
      // body: Text("test")
      //body: TransactionTimeLineView(),
    );
  }
}
