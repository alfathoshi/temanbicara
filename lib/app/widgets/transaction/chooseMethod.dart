import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/bankMethodList.dart';
import 'package:temanbicara/app/widgets/transaction/creditCardMethodList.dart';
import 'package:temanbicara/app/widgets/transaction/eWalletMethodList.dart';

class ChooseMethod extends StatelessWidget {
  final TransactionModel transaction;
  const ChooseMethod({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return GetBuilder<ToggleButtonController>(
      init: ToggleButtonController(),
      builder: (controller) {
        return Column(
          children: [
            Container(
              width: screenWidth - 56,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ToggleButtons(
                  onPressed: (int index) => controller.toggleMethod(index),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  selectedColor: Colors.white,
                  fillColor: primaryColor,
                  color: black,
                  borderColor: primaryColor.withOpacity(0.6),
                  borderWidth: 1,
                  constraints: BoxConstraints(
                    minHeight: 47.0,
                    minWidth: screenWidth / 3 - 21,
                  ),
                  isSelected: controller.selectedMethod,
                  children: controller.method,
                ),
              ),
            ),
            sby24,
            PaymentMethodIndex(
                index: controller.selectedIndex, transaction: transaction)
          ],
        );
      },
    );
  }
}

class PaymentMethodIndex extends StatelessWidget {
  final int index;
  final TransactionModel transaction;
  const PaymentMethodIndex(
      {super.key, required this.index, required this.transaction});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return EWalletMethodList(transaction: transaction);
    } else if (index == 1) {
      return BankPaymentMethodList(transaction: transaction);
    } else {
      return CreditCardMethodList(transaction: transaction);
    }
  }
}
