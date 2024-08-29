import 'package:flutter/material.dart';

import '../themes/fonts.dart';

class WideButton extends StatelessWidget {
  final Function()? get;
  final Color color;
  final String text;
  const WideButton({
    super.key,
    required this.get,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        get?.call();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: buttonLinkXSBold,
          ),
        ),
      ),
    );
  }
}
