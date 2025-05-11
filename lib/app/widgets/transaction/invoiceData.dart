import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/idrFormatter.dart';

class InvoiceData extends StatelessWidget {
  final InvoiceModel invoice;
  const InvoiceData({super.key, required this.invoice});

  String getDayName(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEEE').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    const CircleAvatar(radius: 20),
                    sbX12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.transaction.namaPsikiater,
                          style:
                              h5Bold.copyWith(overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          invoice.transaction.expertise,
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
                  children: [
                    Text("Invoice", style: h6Bold),
                    Text(invoice.invoice)
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
                    Text("Topic", style: h6Bold),
                    Text(invoice.transaction.topik)
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
                    Text("Consultation Method", style: h6Bold),
                    Text(invoice.transaction.metode)
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
                    Text(invoice.transaction.durasi.toString())
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Session", style: h6Bold),
                    Text(invoice.transaction.sesi.toString())
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Schedule", style: h6Bold),
                    Text(
                        "${getDayName(invoice.transaction.jadwal)}, ${invoice.transaction.jadwal}")
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time", style: h6Bold),
                    Text(invoice.transaction.waktu.toString())
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
                    Text("Expired Time", style: h6Bold),
                    Text(invoice.transaction.kadaluarsa)
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
                    Text("Payment Method", style: h6Bold),
                    Text(invoice.metodePembayaran.toString())
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consultation Price", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(
                        invoice.transaction.harga, 2))
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Application Tax.", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(
                        invoice.transaction.appTax, 2))
                  ],
                ),
                sby12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Administration Tax.", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(
                        invoice.transaction.admTax, 2))
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
                    Text(CurrencyFormat.convertToIdr(invoice.hargaTotal, 2),
                        style: h6Bold.copyWith(color: primaryColor))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
