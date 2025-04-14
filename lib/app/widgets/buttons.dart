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
                borderRadius: BorderRadius.circular(20))),
        child: Text(
          text,
          style: h5Bold.copyWith(color: whiteColor),
        ));
  }
}

class MyButtonCustom extends StatelessWidget {
  final Function()? get;
  final Color foreColor;
  final Color backColor;
  final double height;
  final String text;
  const MyButtonCustom({
    super.key,
    required this.get,
    required this.foreColor,
    required this.backColor,
    required this.text,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        get?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor,
        foregroundColor: foreColor,
        minimumSize: Size(
          double.infinity,
          height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: h5Bold.copyWith(color: whiteColor),
      ),
    );
  }
}

class MyButtonOutlinedCustom extends StatelessWidget {
  final Function()? get;
  final Color foreColor;
  final Color backColor;
  final double height;
  final String text;
  const MyButtonOutlinedCustom({
    super.key,
    required this.get,
    required this.foreColor,
    required this.backColor,
    required this.text,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        get?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor,
        foregroundColor: foreColor,
        minimumSize: Size(
          double.infinity,
          height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: foreColor, width: 1),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: h5Bold.copyWith(color: foreColor),
      ),
    );
  }
}
