import 'package:flutter/widgets.dart';

class FavoriteButton extends StatelessWidget {
  final Function()? get;
  final Color colorBorder;
  final Color colorBackground;
  final TextStyle style;
  final String text;
  const FavoriteButton({
    super.key,
    required this.get,
    required this.colorBorder,
    required this.text,
    required this.colorBackground,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        get?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorBackground,
              border: Border.all(
                width: 2,
                color: colorBorder,
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
