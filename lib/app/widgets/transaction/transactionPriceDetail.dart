import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/idrFormatter.dart';

class TransactionPriceDetail extends StatelessWidget {
  final String invoice;
  final String paymentMethod;
  final int price;
  final int appTax;
  final int admTax;
  late final int total;

  TransactionPriceDetail({
    super.key,
    required this.invoice,
    required this.paymentMethod,
    required this.price,
    required this.appTax,
    required this.admTax,
  }) {
    total = price + appTax + admTax;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 33, bottom: 25, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Invoice", style: h7SemiBold),
                Text(invoice, style: h7SemiBold.copyWith(color: grey2Color))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PaymentMethod", style: h7SemiBold),
                Text(paymentMethod,
                    style: h7SemiBold.copyWith(color: grey2Color))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price", style: h7SemiBold),
                Text(CurrencyFormat.convertToIdr(price, 2),
                    style: h7SemiBold.copyWith(color: grey2Color))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Application Tax.", style: h7SemiBold),
                Text(CurrencyFormat.convertToIdr(appTax, 2),
                    style: h7SemiBold.copyWith(color: grey2Color))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Administration Tax.", style: h7SemiBold),
                Text(CurrencyFormat.convertToIdr(admTax, 2),
                    style: h7SemiBold.copyWith(color: grey2Color))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: h7Bold),
                Text(CurrencyFormat.convertToIdr(total, 2),
                    style: h6Bold.copyWith(color: primaryColor))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
