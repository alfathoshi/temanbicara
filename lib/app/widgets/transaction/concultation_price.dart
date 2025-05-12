import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';

class ConcultationPrice extends StatelessWidget {
  final int price;
  const ConcultationPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Concultation Price",
                  style: h7Bold.copyWith(color: black),
                ),
                Text(
                  CurrencyFormat.convertToIdr(price, 2),
                  style: h7Bold.copyWith(color: primaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
