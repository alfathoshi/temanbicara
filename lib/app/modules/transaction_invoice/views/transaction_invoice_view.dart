import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: const Center(
        child: Text(
          'TransactionInvoiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
