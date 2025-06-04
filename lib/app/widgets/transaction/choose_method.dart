import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/widgets/transaction/bank_method_list.dart';

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
    // final methodController = Get.find<TransactionMethodController>();

    return Column(
      children: [
        PaymentMethodIndex(
          transaction: transaction,
          onMethodSelected: onMethodSelected,
        ),
      ],
    );
  }
}

class PaymentMethodIndex extends StatelessWidget {
  final TransactionModel transaction;
  final Function(String methodType) onMethodSelected;

  const PaymentMethodIndex({
    super.key,
    required this.transaction,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BankPaymentMethodList(
      transaction: transaction,
      onMethodSelected: onMethodSelected,
    );
  }
}
