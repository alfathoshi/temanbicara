import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_payment/views/transaction_payment_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/chooseMethod.dart';
import 'package:temanbicara/app/widgets/transaction/concultationPrice.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_method_controller.dart';

class TransactionMethodView extends GetView<TransactionMethodController> {
  final int? price;
  const TransactionMethodView({this.price, super.key});
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
            SizedBox(height: 20),
            TransactionTimeLineViewIndex(index: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0, right: 28, left: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method", style: h5Bold),
                  SizedBox(height: 22),
                  ChooseMethod(
                    price: price!,
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
