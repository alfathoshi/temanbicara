import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_method_controller.dart';

class TransactionMethodView extends GetView<TransactionMethodController> {
  const TransactionMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionMethodView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactionMethodView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
