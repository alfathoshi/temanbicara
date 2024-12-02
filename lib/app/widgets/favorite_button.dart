import 'package:flutter/widgets.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class FavoriteButton extends StatelessWidget {
  final Function()? get;
  final Color colorBorder;
  final Color colorBackground;
  final String text;
  const FavoriteButton({
    super.key,
    required this.get,
    required this.colorBorder,
    required this.text,
    required this.colorBackground,
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
                style: favoriteButton,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
