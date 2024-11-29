import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class PaymentMethodRow extends StatelessWidget {
  final String label;
  final String value;
  final String logo;
  const PaymentMethodRow(
      {super.key,
      required this.label,
      required this.value,
      required this.logo});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RadioButtonController>(builder: (RadioButtonController) {
      return InkWell(
        onTap: () => RadioButtonController.setMethodType(value),
        child: Row(
          children: [
            Text(label, style: h4Bold),
            SizedBox(width: 10),
            Image.asset("assets/images/$logo.png", scale: 2),
            Spacer(),
            Radio<String>(
              value: value,
              groupValue: RadioButtonController.methodType,
              onChanged: (String? value) =>
                  RadioButtonController.setMethodType(value!),
              activeColor: primaryColor,
            )
          ],
        ),
      );
    });
  }
}
