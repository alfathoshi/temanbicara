import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class Transactionvanumber extends StatelessWidget {
  final String vaNumber;
  const Transactionvanumber({
    super.key,
    required this.vaNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: vaNumber));
        Get.snackbar(
          backgroundColor: primaryColor.withOpacity(0.6),
          colorText: Colors.white,
          "Copied!",
          "VA Number copied to clipboard",
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "VA Number",
                    style: h7Bold,
                  ),
                  Spacer(),
                  Text(
                    vaNumber,
                    style: h7SemiBold.copyWith(
                        fontStyle: FontStyle.italic, color: grey2Color),
                  ),
                  sbX12,
                  Icon(
                    Icons.copy_all_rounded,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
