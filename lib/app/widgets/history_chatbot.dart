import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class HistoryChatbot extends StatelessWidget {
  const HistoryChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        bottom: 8,
        right: 16,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Text(
                  'History',
                  style: h6SemiBold,
                ),
              ],
            )),
      ),
    );
  }
}
