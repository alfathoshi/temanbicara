import 'package:flutter/material.dart';
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
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(
          double.infinity,
          56,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: h4Bold.copyWith(color: whiteColor),
      ),
    );
  }
}

class MyButtonCustom extends StatelessWidget {
  final Function()? get;
  final Color foreColor;
  final Color backColor;
  final double width;
  final double height;
  final String text;
  final dynamic icon;
  final TextStyle style;
  const MyButtonCustom({
    super.key,
    required this.get,
    required this.foreColor,
    required this.backColor,
    required this.text,
    required this.height,
    required this.width,
    this.icon,
    required this.style,
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
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: style,
          ),
          if (icon != null) ...[
            const Spacer(),
            icon!,
          ],
        ],
      ),
    );
  }
}

class MyButtonOutlinedCustom extends StatelessWidget {
  final Function()? get;
  final Color foreColor;
  final Color backColor;
  final double height;
  final double width;
  final String text;
  final Icon? icon;
  final TextStyle style;
  const MyButtonOutlinedCustom({
    super.key,
    required this.get,
    required this.foreColor,
    required this.backColor,
    required this.text,
    required this.height,
    required this.width,
    this.icon,
    required this.style,
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
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: foreColor, width: 1),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: style,
          ),
          if (icon != null) ...[
            const Spacer(),
            icon!,
          ],
        ],
      ),
    );
  }
}
