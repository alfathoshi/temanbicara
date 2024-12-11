import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/transactionData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    final TransactionModel transaction = Get.arguments as TransactionModel;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Transaction',
            style: h3Bold,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_rounded)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TransactionTimeLineViewIndex(index: 1),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("Details", style: h4Bold),
                      TransactionData(
                          namaPsikiater: transaction.namaPsikiater,
                          topik: transaction.topik,
                          metode: transaction.metode,
                          durasi: transaction.durasi,
                          jmlSesi: transaction.sesi,
                          jadwalSesi: transaction.jadwal,
                          waktuSesi: transaction.waktu,
                          kadaluarsa: transaction.kadaluarsa,
                          harga: transaction.harga),
                      SizedBox(height: 50),
                      Center(
                        child: SizedBox(
                          width: 205,
                          height: 42,
                          child: ElevatedButton(
                            child: Text('Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Get.toNamed(Routes.TRANSACTION_METHOD,
                                  arguments: transaction);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
