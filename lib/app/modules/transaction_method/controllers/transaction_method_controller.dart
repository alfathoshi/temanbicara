import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class TransactionMethodController extends GetxController {
  var selectedMethod = ''.obs;
  Map<String, dynamic>? consultationResult;

  void setMethod(String method) {
    selectedMethod.value = method;
  }

  Future<void> createConsultation({
    required int scheduleId,
    required int patientId,
    required int amount,
    required String bank,
    String description = "-",
    String problem = "-",
    String summary = "-",
  }) async {
    final url = Uri.parse('${Config.apiEndPoint}/consultation');
    final box = GetStorage();
    final token = box.read('token');

    final Map<String, dynamic> body = {
      'description': description,
      'problem': problem,
      'summary': summary,
      'schedule_id': scheduleId,
      'amount': amount,
      'bank': bank,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        consultationResult = responseData['data'];
        update();

        CustomSnackbar.showSnackbar(
          title: "Success!",
          message: "Consultation Created!",
          status: true,
        );
      } else {
        String errorMessage = 'Failed to create consultation.';

        try {
          final responseBody = json.decode(response.body);
          errorMessage = responseBody['message'] ?? errorMessage;
        } catch (e) {
          selectedMethod.value = '';
        }
      }
    } catch (error) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Creating Consultation Failed!",
        status: false,
      );
    }
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
