import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_method/views/transaction_method_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/transactionData.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
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
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Anggap ini progress bar ya blud", style: h4Bold),
                  SizedBox(height: 30),
                  Text("Details", style: h4Bold),
                  TransactionData(
                      namaPsikiater: "dummy",
                      topik: "dummy",
                      metode: "dummy",
                      durasi: 100,
                      jmlSesi: 1,
                      jadwalSesi: "dummy",
                      waktuSesi: "dummy",
                      kadaluarsa: "dummy",
                      harga: 321670),
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
                          Get.to(() => TransactionMethodView());
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
        ));
  }
}
