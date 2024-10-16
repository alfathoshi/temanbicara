import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_success_controller.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionSuccessView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactionSuccessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
