import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class PaymentMethodRow extends StatelessWidget {
  final String label;
  final String value;
  final String logo;
  final bool isAvailable;

  const PaymentMethodRow({
    super.key,
    required this.label,
    required this.value,
    required this.logo,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RadioButtonController>(builder: (RadioButtonController) {
      return Stack(
        children: [
          InkWell(
            onTap: isAvailable
                ? () => RadioButtonController.setMethodType(value)
                : null,
            child: Row(
              children: [
                Text(
                  label,
                  style:
                      isAvailable ? h4Bold : h4Bold.copyWith(color: grey4Color),
                ),
                sbX12,
                Opacity(
                  child: Image.asset(
                    "assets/images/$logo.png",
                    scale: 2,
                  ),
                  opacity: isAvailable ? 1 : 0,
                ),
                Spacer(),
                Radio<String>(
                  value: value,
                  groupValue: RadioButtonController.methodType,
                  onChanged: isAvailable
                      ? (String? value) =>
                          RadioButtonController.setMethodType(value!)
                      : null,
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          if (!isAvailable)
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    "Unavailable",
                    style: h5Bold.copyWith(
                        color: black, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
