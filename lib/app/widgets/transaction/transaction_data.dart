// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';

class TransactionData extends StatelessWidget {
  final String namaPsikiater,
      topik,
      metode,
      jadwalSesi,
      waktuSesi,
      kadaluarsa,
      expertise,
      image,
      durasi;
  final jmlSesi, harga;
  const TransactionData(
      {super.key,
      required this.namaPsikiater,
      required this.image,
      required this.expertise,
      required this.topik,
      required this.metode,
      required this.jadwalSesi,
      required this.waktuSesi,
      required this.kadaluarsa,
      required this.durasi,
      required this.jmlSesi,
      required this.harga});

  String getDayName(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEEE').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(image),
                    ),
                    sbX12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaPsikiater,
                          style:
                              h5Bold.copyWith(overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          expertise,
                          style: h7Regular.copyWith(
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
                sby12,
                const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Topic", style: h6Bold), Text(topik)],
                ),
                sby24,
                const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consultation Method", style: h6Bold),
                    Text(metode)
                  ],
                ),
                sby24,
                const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Duration", style: h6Bold),
                    Text(durasi.toString())
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Session", style: h6Bold),
                    Text(jmlSesi.toString())
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Schedule", style: h6Bold),
                    Text("${getDayName(jadwalSesi)}, $jadwalSesi")
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time", style: h6Bold),
                    Text(waktuSesi.toString())
                  ],
                ),
                sby24,
                const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(harga, 2),
                        style: h6Bold.copyWith(color: primaryColor))
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
