import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class MentalMatrix extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String title;
  final String detail;
  final String image;
  final String matrixValue;
  final bool isFilled;

  const MentalMatrix({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.detail,
    required this.image,
    required this.matrixValue,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: border,
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        height: 83,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                scale: 2.5,
              ),
              sbx8,
              Expanded(
                child: isFilled
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Mental Matrix",
                            style: h7Regular,
                          ),
                          Text(
                            title,
                            style: h6SemiBold,
                          ),
                          Text(
                            detail,
                            style: h7Regular,
                          ),
                        ],
                      )
                    : Text(
                        detail,
                        style: h6Regular,
                      ),
              ),
              sbx8,
              isFilled
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/lingkaranMatrix.png',
                          scale: 2,
                        ),
                        Text(
                          matrixValue,
                          style: h5Medium.copyWith(
                            color: primaryColor,
                          ),
                        )
                      ],
                    )
                  : Container(
                      width: 53,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: primaryColor,
                      ),
                      child: Image.asset(
                        'assets/images/pencil.png',
                        scale: 2,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
