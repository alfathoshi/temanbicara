import 'package:flutter/widgets.dart';
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
    return GestureDetector(
      onTap: () {
        get?.call();
      },
      child: Container(
        height: 36,
        width: 162,
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
