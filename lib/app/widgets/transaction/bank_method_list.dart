import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/concultation_price.dart';
import 'package:temanbicara/app/widgets/transaction/payment_method_row.dart';

List<String> bankTransferList = ["BCA", "BNI", "BRI", "CIMB"];

class BankPaymentMethodList extends StatelessWidget {
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const BankPaymentMethodList({
    super.key,
    required this.transaction,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionMethodController>();

    void onSelect(String bank) {
      controller.setMethod(bank);
      onMethodSelected(bank);
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
              children: bankTransferList.map((bank) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onSelect(bank);
                      },
                      child: PaymentMethodRow(
                        label: bank,
                        value: bank,
                        logo: "${bank.toLowerCase()}Logo",
                        onTap: () {
                          onMethodSelected(bank);
                        },
                      ),
                    ),
                    if (bank != bankTransferList.last)
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
