import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/transaction/invoice_data.dart';
import 'package:temanbicara/app/widgets/transaction/transaction_timeline_view.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceView extends GetView<TransactionInvoiceController> {
  const TransactionInvoiceView({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.sizeOf(context).height;

    final data = Get.arguments as Map;
    final InvoiceModel invoice = data['invoice'];
    // ignore: unused_local_variable
    final TransactionModel transaction = data['transaction'];
    // ignore: unused_local_variable
    final consultationData = data['consultationData'];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar(
          title: Text(
            "Transaction",
            style: h3Bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              sby24,
              const SizedBox(
                height: 60,
                child: Expanded(
                  child: TransactionTimeLineViewIndex(index: 4),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sby5,
                      Text("Invoice", style: h4Bold),
                      sby24,
                      InvoiceData(invoice: invoice),
                      sby16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return InkWell(
                              onTap: controller.isSharing.value
                                  ? null
                                  : () => controller.shareInvoice(invoice),
                              child: Row(
                                children: [
                                  sbx5,
                                  controller.isSharing.value
                                      ? SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: primaryColor,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/shareInvoice.png'),
                                  sbx5,
                                  Text(
                                    controller.isSharing.value
                                        ? "Sharing..."
                                        : "Share Invoice",
                                    style: h6SemiBold.copyWith(
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Obx(() {
                            return InkWell(
                              onTap: controller.isDownloading.value
                                  ? null
                                  : () => controller.downloadInvoice(invoice),
                              child: Row(
                                children: [
                                  controller.isDownloading.value
                                      ? SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: primaryColor,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/downloadInvoice.png'),
                                  sbx5,
                                  Text(
                                    controller.isDownloading.value
                                        ? "Saving..."
                                        : "Download Invoice",
                                    style: h6SemiBold.copyWith(
                                        color: primaryColor),
                                  ),
                                  sbX12,
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                      sby48,
                      MyButton(
                        color: primaryColor,
                        text: 'Done',
                        get: () {
                          Get.offAllNamed(
                            Routes.NAVIGATION_BAR,
                            arguments: {"indexPage": 0},
                          );
                        },
                      ),
                      sby36,
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
