import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/transactionData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    final TransactionModel transaction = Get.arguments as TransactionModel;

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Trasanctions',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              sby24,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TransactionTimeLineViewIndex(index: 1),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sby5,
                      Text("Details", style: h4Bold),
                      TransactionData(
                          namaPsikiater: transaction.namaPsikiater,
                          expertise: transaction.expertise,
                          topik: transaction.topik,
                          metode: transaction.metode,
                          durasi: transaction.durasi,
                          jmlSesi: transaction.sesi,
                          jadwalSesi: transaction.jadwal,
                          waktuSesi: transaction.waktu,
                          kadaluarsa: transaction.kadaluarsa,
                          harga: transaction.harga),
                      sby24,
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
