import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_success/controllers/transaction_success_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
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
      body: Center(
        child: Obx(() {
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

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Berhasil wok", style: h1Bold),
              sby48,
              Text(
                "Mengalihkan dalam ${controller.countdown} detik...",
                style: h6Regular,
              ),
            ],
          );
        }),
      ),
    );
  }
}
