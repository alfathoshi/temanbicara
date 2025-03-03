import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/modules/transaction_payment/views/transaction_payment_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/transaction/concultationPrice.dart';
import 'package:temanbicara/app/widgets/transaction/paymentMethodRow.dart';

List<String> bankTransferList = ["BCA", "Mandiri", "BNI", "BRI", "BSI", "NOBU"];

class BankPaymentMethodList extends StatelessWidget {
  final TransactionModel transaction;
  const BankPaymentMethodList({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final radioController = Get.put(RadioButtonController());
    Get.put(RadioButtonController());
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
                    label: "BCA", value: bankTransferList[0], logo: "bcaLogo"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 1,
                    thickness: 1.5,
                    color: grey4Color,
                  ),
                ),
                PaymentMethodRow(
                    label: "Mandiri",
                    value: bankTransferList[1],
                    logo: "mandiriLogo"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 1,
                    thickness: 1.5,
                    color: grey4Color,
                  ),
                ),
                PaymentMethodRow(
                    label: "BNI", value: bankTransferList[2], logo: "bniLogo"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 1,
                    thickness: 1.5,
                    color: grey4Color,
                  ),
                ),
                PaymentMethodRow(
                    label: "BRI", value: bankTransferList[3], logo: "briLogo"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 1,
                    thickness: 1.5,
                    color: grey4Color,
                  ),
                ),
                PaymentMethodRow(
                    label: "BSI", value: bankTransferList[4], logo: "bsiLogo"),
              ],
            ),
          ),
        ),
        sby24,
        ConcultationPrice(price: transaction.harga),
        sby24,
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
                if (radioController.methodType.isNotEmpty) {
                  Get.to(
                      () => TransactionPaymentView(
                            paymentMethod: radioController.methodType,
                          ),
                      arguments: transaction);
                } else {
                  Get.snackbar(
                    backgroundColor: primaryColor.withOpacity(0.6),
                    colorText: Colors.white,
                    "Silahkan pilih Metode Pembayaran",
                    "Please select payment method before proceeding.",
                  );
                }
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
