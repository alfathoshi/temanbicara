import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/transaction.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/concultation_price.dart';
import 'package:temanbicara/app/widgets/transaction/payment_method_row.dart';

List<String> eWalletList = ["Gopay", "ShopeePay", "OVO", "Dana"];

class EWalletMethodList extends StatelessWidget {
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const EWalletMethodList({
    super.key,
    required this.onMethodSelected,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    void onSelect(String wallet) {
      onMethodSelected(wallet);
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
              children: eWalletList.map((wallet) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => onSelect(wallet),
                      child: PaymentMethodRow(
                        label: wallet,
                        value: wallet,
                        logo: "${wallet.toLowerCase()}Logo",
                        isAvailable: false,
                      ),
                    ),
                    if (wallet != eWalletList.last)
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
