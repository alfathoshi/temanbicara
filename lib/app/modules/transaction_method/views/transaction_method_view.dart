import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_payment/views/transaction_payment_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/transaction/chooseMethod.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_method_controller.dart';

class TransactionMethodView extends GetView<TransactionMethodController> {
  const TransactionMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionMethodController());
    final TransactionModel transaction = Get.arguments as TransactionModel;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: UnderlineInputBorder(borderSide: BorderSide(color: border)),
        title: Text('Transaction', style: h3Bold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sby24,
            SizedBox(height: 60, child: TransactionTimeLineViewIndex(index: 2)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method", style: h5Bold),
                  sby24,
                  ChooseMethod(
                    transaction: transaction,
                    onMethodSelected: (String methodType) {
                      controller.setMethod(methodType);
                    },
                  ),
                  MyButton(
                    get: () async {
                      Get.dialog(
                        Center(
                            child:
                                CircularProgressIndicator(color: primaryColor)),
                        barrierDismissible: false,
                      );

                      await Future.delayed(Duration(seconds: 2));
                      Get.back();
                      Get.to(
                        () => TransactionPaymentView(
                            paymentMethod: "Bank Transfer"),
                        arguments: transaction,
                      );
                    },
                    color: primaryColor,
                    text: "Book Schedule",
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
