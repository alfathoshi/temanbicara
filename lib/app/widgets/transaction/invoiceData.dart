import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/idrFormatter.dart';

class InvoiceData extends StatelessWidget {
  final InvoiceModel invoice;
  const InvoiceData({super.key, required this.invoice});

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
                        Text(invoice.transaction.namaPsikiater, style: h5Bold),
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
                  children: [
                    Text("Invoice", style: h6Bold),
                    Text(invoice.invoice)
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
                    Text("Topic", style: h6Bold),
                    Text(invoice.transaction.topik)
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
                    Text("Consultation Method", style: h6Bold),
                    Text(invoice.transaction.metode)
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
                    Text(invoice.transaction.durasi.toString())
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Session", style: h6Bold),
                    Text(invoice.transaction.sesi.toString())
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Schedule", style: h6Bold),
                    Text(invoice.transaction.jadwal)
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time", style: h6Bold),
                    Text(invoice.transaction.waktu.toString())
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
                    Text(invoice.transaction.kadaluarsa)
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
                    Text("Payment Method", style: h6Bold),
                    Text(invoice.metodePembayaran.toString())
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consultation Price", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(
                        invoice.transaction.harga, 2))
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Application Tax.", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(invoice.appTax, 2))
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Administration Tax.", style: h6Bold),
                    Text(CurrencyFormat.convertToIdr(invoice.admTax, 2))
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
