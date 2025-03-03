import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/idrFormatter.dart';

class TransactionData extends StatelessWidget {
  final String namaPsikiater,
      topik,
      metode,
      jadwalSesi,
      waktuSesi,
      kadaluarsa,
      expertise;
  final int durasi, jmlSesi, harga;
  const TransactionData(
      {super.key,
      required this.namaPsikiater,
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
          height: 530,
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
                    sby12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            namaPsikiater,
                            style: h5Bold.copyWith(
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 2),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            expertise,
                            style: h7Regular.copyWith(
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                sby12,
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Topik", style: h6Bold), Text(topik)],
                ),
                sby24,
                Divider(
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
                Divider(
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
                    Text("${getDayName(jadwalSesi)}, ${jadwalSesi}")
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
                Divider(
                  height: 1,
                  thickness: 1.5,
                  color: grey4Color,
                ),
                sby24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expired Time", style: h6Bold),
                    Text(kadaluarsa)
                  ],
                ),
                sby24,
                Divider(
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
