import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/modules/transaction_payment/views/transaction_payment_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/transaction/choose_method.dart';
import 'package:temanbicara/app/widgets/transaction/transaction_timeline_view.dart';

import '../controllers/transaction_method_controller.dart';

class TransactionMethodView extends GetView<TransactionMethodController> {
  const TransactionMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userID = box.read('id');
    final controller = Get.put(TransactionMethodController());
    final TransactionModel transaction = Get.arguments as TransactionModel;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Transaction',
          style: h3Bold,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: grey4Color,
            height: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sby24,
            const SizedBox(
                height: 60, child: TransactionTimeLineViewIndex(index: 2)),
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
                      if (controller.selectedMethod.value.isEmpty) {
                        Get.snackbar(
                          "Payment Method Not Selected",
                          "Please select a payment method before proceeding.",
                          backgroundColor: Colors.red.withValues(alpha: 0.6),
                          colorText: Colors.white,
                        );
                        return;
                      }

                      showDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        builder: (_) => Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      );

                      final consultationFuture = controller.createConsultation(
                        scheduleId: transaction.selectedID,
                        patientId: userID,
                        amount: transaction.harga,
                        bank: controller.selectedMethod.value.toLowerCase(),
                      );

                      await Future.wait([
                        consultationFuture,
                        Future.delayed(const Duration(seconds: 2)),
                      ]);

                      Navigator.of(Get.context!).pop();

                      if (controller.consultationResult == null) {
                        Get.snackbar(
                          "Booking Failed",
                          "Unable to process your consultation. Please try again.",
                          backgroundColor: Colors.red.withValues(alpha: 0.6),
                          colorText: Colors.white,
                        );
                        return;
                      }

                      final data = controller.consultationResult;

                      Get.to(
                        () => TransactionPaymentView(
                            paymentMethod: "Bank Transfer"),
                        arguments: {
                          "transaction": transaction,
                          "data": data,
                        },
                      );
                    },
                    color: primaryColor,
                    text: 'Book Schedule',
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
