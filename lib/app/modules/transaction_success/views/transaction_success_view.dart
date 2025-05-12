// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_success/controllers/transaction_success_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map;
    final consultationData = args['consultationData'];
    final TransactionModel transaction = args['transaction'];
    final InvoiceModel invoice = args['invoice'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startCountdown();
    });

    return Scaffold(
      backgroundColor: whiteColor,
      body: Obx(() {
        if (controller.countdown.value == 0) {
          Future.microtask(() {
            Get.offAllNamed(
              Routes.TRANSACTION_INVOICE,
              arguments: {
                'consultationData': consultationData,
                'transaction': transaction,
                'invoice': invoice,
              },
            );
          });
        }

        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(57),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(126, 149, 78, 0.05),
                          offset: Offset(3, 3),
                          blurRadius: 18,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset("assets/images/paymentCheck.png"),
                    ),
                  ),
                  sby48,
                  Text("You’re All Set!", style: h1Bold),
                  sby8,
                  Text(
                    "Your session has been booked successfully.",
                    style: h6Regular.copyWith(color: grey2Color),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "A step toward healing is a brave one",
                    style: h6Regular.copyWith(color: grey2Color),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                "Taking you there in ${controller.countdown} seconds...",
                style: h6Regular,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      }),
    );
  }
}
