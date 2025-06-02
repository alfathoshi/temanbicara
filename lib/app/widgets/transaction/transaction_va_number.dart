import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class TransactionVaNumberBorder extends StatelessWidget {
  final String vaNumber;
  const TransactionVaNumberBorder({
    super.key,
    required this.vaNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: vaNumber));
        CustomSnackbar.showSnackbar(
          title: "Success!",
          message: "VA Number Copied!",
          status: true,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "VA Number",
                    style: h7Bold,
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      vaNumber,
                      style: h7SemiBold.copyWith(
                        fontStyle: FontStyle.italic,
                        color: grey2Color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  sbX12,
                  const Icon(
                    Icons.copy_all_rounded,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionVaNumber extends StatelessWidget {
  final String vaNumber;
  const TransactionVaNumber({
    super.key,
    required this.vaNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: vaNumber));
        CustomSnackbar.showSnackbar(
          title: "Success!",
          message: "VA Number Copied!",
          status: true,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "VA Number",
            style: h7Bold.copyWith(color: grey2Color),
          ),
          sby8,
          Row(
            children: [
              Text(
                vaNumber,
                style: h7SemiBold.copyWith(fontStyle: FontStyle.italic),
              ),
              sbX12,
              const Icon(
                Icons.copy_all_rounded,
                size: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
