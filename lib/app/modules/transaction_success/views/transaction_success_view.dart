import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_success_controller.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({super.key});
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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TransactionTimeLineViewIndex(index: 4),
              LottieBuilder.asset(
                "assets/animations/successIcon.json",
                repeat: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
