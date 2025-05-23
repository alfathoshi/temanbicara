import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/bank_method_list.dart';
import 'package:temanbicara/app/widgets/transaction/creditcard_method_list.dart';
import 'package:temanbicara/app/widgets/transaction/ewallet_method_list.dart';

class ChooseMethod extends StatelessWidget {
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const ChooseMethod({
    super.key,
    required this.transaction,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    // ignore: unused_local_variable
    final radioController = Get.put(RadioButtonController());
    // ignore: unused_local_variable
    final methodController = Get.find<TransactionMethodController>();
    return GetBuilder<ToggleButtonController>(
      init: ToggleButtonController(),
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              width: screenWidth - 56,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ToggleButtons(
                  onPressed: (int index) => controller.toggleMethod(index),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  selectedColor: Colors.white,
                  fillColor: primaryColor,
                  color: black,
                  borderColor: primaryColor.withValues(alpha: 0.6),
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
              index: controller.selectedIndex,
              transaction: transaction,
              onMethodSelected: onMethodSelected,
            ),
          ],
        );
      },
    );
  }
}

class PaymentMethodIndex extends StatelessWidget {
  final int index;
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const PaymentMethodIndex({
    super.key,
    required this.index,
    required this.transaction,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return EWalletMethodList(
          transaction: transaction,
          onMethodSelected: onMethodSelected,
        );
      case 1:
        return BankPaymentMethodList(
          transaction: transaction,
          onMethodSelected: onMethodSelected,
        );
      default:
        return CreditCardMethodList(
          transaction: transaction,
          onMethodSelected: onMethodSelected,
        );
    }
  }
}
