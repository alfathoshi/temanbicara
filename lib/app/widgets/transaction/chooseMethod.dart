import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/transaction_method/controllers/transaction_method_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/transaction/bankMethodList.dart';
import 'package:temanbicara/app/widgets/transaction/creditCardMethodList.dart';
import 'package:temanbicara/app/widgets/transaction/eWalletMethodList.dart';

class ChooseMethod extends StatelessWidget {
  const ChooseMethod({super.key});

  @override
  Widget build(BuildContext context) {
    //final ToggleButtonController controller = Get.put(ToggleButtonController());
    return GetBuilder<ToggleButtonController>(
      init: ToggleButtonController(),
      builder: (controller) {
        return Column(
          children: [
            ToggleButtons(
              onPressed: (int index) => controller.toggleMethod(index),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              selectedColor: Colors.white,
              fillColor: primaryColor,
              color: black,
              borderColor: primaryColor.withOpacity(0.6),
              borderWidth: 1,
              constraints: const BoxConstraints(
                minHeight: 47.0,
                minWidth: 110,
              ),
              isSelected: controller.selectedMethod,
              children: controller.method,
            ),
            SizedBox(height: 22),
            PaymentMethodIndex(index: controller.selectedIndex)
          ],
        );
      },
    );
  }
}

// class ChooseMethod extends StatefulWidget {
//   const ChooseMethod({super.key});

//   @override
//   State<ChooseMethod> createState() => _ChooseMethodState();
// }

// class _ChooseMethodState extends State<ChooseMethod> {
//   final List<bool> _selectedMethod = <bool>[true, false, false];
//   final List<Widget> Method = <Widget>[
//     Text('E - Wallet', style: h6SemiBold.copyWith(color: whiteColor)),
//     Text('Bank Transfer', style: h6SemiBold.copyWith(color: primaryColor)),
//     Text('Credit Card', style: h6SemiBold.copyWith(color: primaryColor))
//   ];
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ToggleButtons(
//           onPressed: (int index) {
//             setState(() {
//               for (int i = 0; i < _selectedMethod.length; i++) {
//                 selectedIndex = index;
//                 print(selectedIndex);
//                 _selectedMethod[i] = i == index;
//                 Method[i] = _selectedMethod[i]
//                     ? Text((Method[i] as Text).data!,
//                         style: h6SemiBold.copyWith(color: whiteColor))
//                     : Text((Method[i] as Text).data!,
//                         style: h6SemiBold.copyWith(color: primaryColor));
//                 ;
//               }
//             });
//           },
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//           selectedColor: Colors.white,
//           fillColor: primaryColor,
//           color: black,
//           borderColor: primaryColor.withOpacity(0.6),
//           borderWidth: 1,
//           constraints: const BoxConstraints(
//             minHeight: 47.0,
//             minWidth: 110,
//           ),
//           isSelected: _selectedMethod,
//           children: Method,
//         ),
//         SizedBox(height: 22),
//         PaymentMethodIndex(index: selectedIndex)
//       ],
//     );
//   }
// }

class PaymentMethodIndex extends StatelessWidget {
  final int index;
  const PaymentMethodIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return EWalletMethodList();
    } else if (index == 1) {
      return BankPaymentMethodList();
    } else {
      return CreditCardMethodList();
    }
  }
}
