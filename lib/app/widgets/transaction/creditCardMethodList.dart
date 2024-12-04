import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/modules/transaction_payment/views/transaction_payment_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/transaction/concultationPrice.dart';
import 'package:temanbicara/app/widgets/transaction/paymentMethodRow.dart';

List<String> creditCardList = ["Visa", "Mastercard"];

class CreditCardMethodList extends StatelessWidget {
  final TransactionModel transaction;
  const CreditCardMethodList({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put(RadioButtonController());
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 33, bottom: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentMethodRow(
                    label: "Visa", value: creditCardList[0], logo: "visaLogo"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 1,
                    thickness: 1.5,
                    color: grey4Color,
                  ),
                ),
                PaymentMethodRow(
                    label: "MasterCard",
                    value: creditCardList[1],
                    logo: "masterCardLogo"),
              ],
            ),
          ),
        ),
        SizedBox(height: 22),
        ConcultationPrice(price: transaction.harga),
        SizedBox(height: 25),
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
                Get.to(
                    TransactionPaymentView(
                      paymentMethod: radioController.methodType,
                    ),
                    arguments: transaction);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
