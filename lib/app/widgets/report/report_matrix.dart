import 'package:flutter/widgets.dart';

import '../../themes/colors.dart';
import '../../themes/fonts.dart';

class ReportMatrix extends StatelessWidget {
  final String image;
  final Function onPressed;
  final String title;
  final String description;
  final String matrixValue;
  final Color color;

  const ReportMatrix(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.description,
      required this.image,
      required this.matrixValue,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.maxWidth;
        final double containerHeight = containerWidth * 0.25;

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFBDCF99).withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: containerWidth * 0.05,
              vertical: containerHeight * 0.1,
            ),
            child: GestureDetector(
              onTap: () => onPressed(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        Image.asset(
                          image,
                          scale: 2.5,
                          width: containerHeight * 0.5,
                          height: containerHeight * 0.5,
                        ),
                        SizedBox(width: containerWidth * 0.03),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: h6Bold,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                description,
                                style: h5Regular,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/lingkaranMatrix.png',
                          scale: 2,
                          width: containerHeight * 0.6,
                          height: containerHeight * 0.6,
                        ),
                        Text(
                          matrixValue,
                          style: h5Medium.copyWith(
                            color: primaryColor,
                            fontSize: containerHeight * 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
