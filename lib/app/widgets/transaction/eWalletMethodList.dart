import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/transaction/paymentMethodRow.dart';

List<String> EWalletList = ["Gopay", "ShopeePay", "OVO", "Dana"];

class EWalletMethodList extends StatelessWidget {
  const EWalletMethodList({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RadioButtonController());
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
            PaymentMethodRow(
                label: "Gopay", value: EWalletList[0], logo: "gopayLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            PaymentMethodRow(
                label: "ShopeePay",
                value: EWalletList[1],
                logo: "shopeePayLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            PaymentMethodRow(
                label: "OVO", value: EWalletList[2], logo: "ovoLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            PaymentMethodRow(
                label: "Dana", value: EWalletList[3], logo: "danaLogo"),
          ],
        ),
      ),
    );
  }
}
