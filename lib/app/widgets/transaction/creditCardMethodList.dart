import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/concultationPrice.dart';
import 'package:temanbicara/app/widgets/transaction/paymentMethodRow.dart';

List<String> creditCardList = ["Visa", "Mastercard"];

class CreditCardMethodList extends StatelessWidget {
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const CreditCardMethodList({
    super.key,
    required this.transaction,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    void onSelect(String card) {
      onMethodSelected(card);
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: creditCardList.map((card) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => onSelect(card),
                      child: PaymentMethodRow(
                        label: card,
                        value: card,
                        logo: "${card.toLowerCase()}Logo",
                        isAvailable: false,
                      ),
                    ),
                    if (card != creditCardList.last)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Divider(
                          height: 1,
                          thickness: 1.5,
                          color: grey4Color,
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        sby24,
        ConcultationPrice(
          price: transaction.harga + transaction.admTax + transaction.appTax,
        ),
        sby36,
      ],
    );
  }
}
