import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TransactionController extends GetxController {
  //TODO: Implement TransactionController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

class TransactionData extends StatelessWidget {
  final String namaPsikiater, topik, metode, jadwalSesi, waktuSesi, kadaluarsa;
  final int durasi, jmlSesi, harga;

  const TransactionData(
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
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 19),
        Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(21),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 20),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(namaPsikiater, style: h5Bold),
                        SizedBox(height: 2),
                        Text("Psikolog/Psikiater", style: h7RegularShade)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Topik", style: h6Bold), Text(topik)],
                ),
                SizedBox(height: 22),
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consultation Method", style: h6Bold),
                    Text(metode)
                  ],
                ),
                SizedBox(height: 22),
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Duration", style: h6Bold),
                    Text(durasi.toString())
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Session", style: h6Bold),
                    Text(jmlSesi.toString())
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Schedule", style: h6Bold), Text(jadwalSesi)],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time", style: h6Bold),
                    Text(durasi.toString())
                  ],
                ),
                SizedBox(height: 22),
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expired Time", style: h6Bold),
                    Text(kadaluarsa)
                  ],
                ),
                SizedBox(height: 22),
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price", style: h6Bold),
                    Text(harga.toString())
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
