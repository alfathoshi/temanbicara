import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? get;
  final Color color;
  final String text;
  const MyButton({
    super.key,
    required this.get,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          get?.call();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(
              double.infinity,
              44,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: h5Bold.copyWith(color: whiteColor),
        ));
  }
}
