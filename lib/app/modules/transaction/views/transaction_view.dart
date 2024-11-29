import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_method/views/transaction_method_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/transactionData.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimelineView.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  final String namaPsikiater;
  final String topik;
  final String metode;
  final int durasi;
  final int jmlSesi;
  final String jadwalSesi;
  final String waktuSesi;
  final String kadaluarsa;
  final int harga;

  const TransactionView(
      {required this.namaPsikiater,
      required this.topik,
      required this.metode,
      required this.durasi,
      required this.jmlSesi,
      required this.jadwalSesi,
      required this.waktuSesi,
      required this.kadaluarsa,
      required this.harga,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Transaction',
            style: h3Bold,
          ),
          leading: Icon(Icons.arrow_back_rounded),
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
                          namaPsikiater: namaPsikiater,
                          topik: topik,
                          metode: metode,
                          durasi: durasi,
                          jmlSesi: jmlSesi,
                          jadwalSesi: jadwalSesi,
                          waktuSesi: waktuSesi,
                          kadaluarsa: kadaluarsa,
                          harga: harga),
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
                              Get.to(() => TransactionMethodView(price: harga));
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
