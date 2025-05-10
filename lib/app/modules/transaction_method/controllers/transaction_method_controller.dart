import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TransactionMethodController extends GetxController {
  var selectedMethod = ''.obs;

  void setMethod(String method) {
    selectedMethod.value = method;
    print(selectedMethod.value);
  }

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
}

class RadioButtonController extends GetxController {
  String _methodType = "";
  String get methodType => _methodType;
  void setMethodType(String type) {
    _methodType = type;
    update();
  }
}

class ToggleButtonController extends GetxController {
  List<bool> selectedMethod = <bool>[true, false, false];
  List<Widget> method = <Widget>[
    Text('E - Wallet', style: h6SemiBold.copyWith(color: whiteColor)),
    Text('Bank Transfer', style: h6SemiBold.copyWith(color: primaryColor)),
    Text('Credit Card', style: h6SemiBold.copyWith(color: primaryColor))
  ];

  int selectedIndex = 0;

  void toggleMethod(int index) {
    selectedIndex = index;
    for (int i = 0; i < selectedMethod.length; i++) {
      selectedMethod[i] = i == index;
      method[i] = Text(
        (method[i] as Text).data!,
        style: h6SemiBold.copyWith(
          color: selectedMethod[i] ? whiteColor : primaryColor,
        ),
      );
    }
    update();
  }
}
