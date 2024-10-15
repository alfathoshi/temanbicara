import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

enum EWalletList { Gopay, ShopeePay, OVO, Dana }

enum BankTransferList { BCA, Mandiri, BNI, BRI, BSI, NOBU }

enum creditCardList { Visa, Mastercard }

class TransactionMethodController extends GetxController {
  //TODO: Implement TransactionMethodController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

class ChooseMethod extends StatefulWidget {
  const ChooseMethod({super.key});

  @override
  State<ChooseMethod> createState() => _ChooseMethodState();
}

class _ChooseMethodState extends State<ChooseMethod> {
  final List<bool> _selectedMethod = <bool>[true, false, false];
  final List<Widget> Method = <Widget>[
    Text('E - Wallet', style: h6SemiBold.copyWith(color: whiteColor)),
    Text('Bank Transfer', style: h6SemiBold.copyWith(color: primaryColor)),
    Text('Credit Card', style: h6SemiBold.copyWith(color: primaryColor))
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selectedMethod.length; i++) {
                selectedIndex = index;
                print(selectedIndex);
                _selectedMethod[i] = i == index;
                Method[i] = _selectedMethod[i]
                    ? Text((Method[i] as Text).data!,
                        style: h6SemiBold.copyWith(color: whiteColor))
                    : Text((Method[i] as Text).data!,
                        style: h6SemiBold.copyWith(color: primaryColor));
                ;
              }
            });
          },
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
          isSelected: _selectedMethod,
          children: Method,
        ),
        SizedBox(height: 22),
        PaymentMethodIndex(index: selectedIndex)
      ],
    );
  }
}

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

class EWalletMethodList extends StatefulWidget {
  @override
  State<EWalletMethodList> createState() => _EWalletPaymentMethodListState();
}

class _EWalletPaymentMethodListState extends State<EWalletMethodList> {
  EWalletList? _selectedEWallet = EWalletList.ShopeePay;
  @override
  Widget build(BuildContext context) {
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
            _buildEWalletRadioRow("Gopay", EWalletList.Gopay, "gopayLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildEWalletRadioRow(
                "Shopee Pay", EWalletList.ShopeePay, "shopeePayLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildEWalletRadioRow("OVO", EWalletList.OVO, "ovoLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildEWalletRadioRow("Dana", EWalletList.Dana, "danaLogo"),
          ],
        ),
      ),
    );
  }

  Widget _buildEWalletRadioRow(String label, EWalletList value, String logo) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedEWallet = value;
        });
      },
      child: Row(
        children: [
          Text(label, style: h4Bold),
          SizedBox(width: 10),
          Image.asset("assets/images/$logo.png", scale: 2),
          Spacer(),
          Radio<EWalletList>(
            value: value,
            groupValue: _selectedEWallet,
            onChanged: (newValue) {
              setState(() {
                _selectedEWallet = newValue!;
              });
            },
            activeColor: primaryColor,
          )
        ],
      ),
    );
  }
}

class BankPaymentMethodList extends StatefulWidget {
  const BankPaymentMethodList({super.key});

  @override
  State<BankPaymentMethodList> createState() => _BankPaymentMethodListState();
}

class _BankPaymentMethodListState extends State<BankPaymentMethodList> {
  BankTransferList? _selectedBankTransfer = BankTransferList.BCA;
  @override
  Widget build(BuildContext context) {
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
            _buildBankTransferRadioRow("BCA", BankTransferList.BCA, "bcaLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildBankTransferRadioRow(
                "Mandiri", BankTransferList.Mandiri, "mandiriLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildBankTransferRadioRow("BNI", BankTransferList.BNI, "bniLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildBankTransferRadioRow("BRI", BankTransferList.BRI, "briLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildBankTransferRadioRow("BSI", BankTransferList.BSI, "bsiLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildBankTransferRadioRow(
                "NOBU", BankTransferList.NOBU, "nobuLogo"),
          ],
        ),
      ),
    );
  }

  Widget _buildBankTransferRadioRow(
      String label, BankTransferList value, String logo) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedBankTransfer = value;
        });
      },
      child: Row(
        children: [
          Text(label, style: h4Bold),
          SizedBox(width: 10),
          Image.asset("assets/images/$logo.png", scale: 2),
          Spacer(),
          Radio<BankTransferList>(
            value: value,
            groupValue: _selectedBankTransfer,
            onChanged: (newValue) {
              setState(() {
                _selectedBankTransfer = newValue!;
              });
            },
            activeColor: primaryColor,
          )
        ],
      ),
    );
  }
}

class CreditCardMethodList extends StatefulWidget {
  const CreditCardMethodList({super.key});

  @override
  State<CreditCardMethodList> createState() => _CreditCardMethodListState();
}

class _CreditCardMethodListState extends State<CreditCardMethodList> {
  creditCardList _selectedCreditCard = creditCardList.Mastercard;
  @override
  Widget build(BuildContext context) {
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
            _buildCreditCardRadioRow("Visa", creditCardList.Visa, "visaLogo"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: grey4Color,
              ),
            ),
            _buildCreditCardRadioRow(
                "Mastercard", creditCardList.Mastercard, "mastercardLogo"),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardRadioRow(
      String label, creditCardList value, String logo) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCreditCard = value;
        });
      },
      child: Row(
        children: [
          Text(label, style: h4Bold),
          SizedBox(width: 10),
          Image.asset("assets/images/$logo.png", scale: 2),
          Spacer(),
          Radio<creditCardList>(
            value: value,
            groupValue: _selectedCreditCard,
            onChanged: (newValue) {
              setState(() {
                _selectedCreditCard = newValue!;
              });
            },
            activeColor: primaryColor,
          )
        ],
      ),
    );
  }
}
