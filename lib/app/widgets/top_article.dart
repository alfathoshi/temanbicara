import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TopArticle extends StatelessWidget {
  const TopArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: 326,
        height: 149,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            color: border,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  'assets/images/article1.png',
                  scale: 4,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Title',
                  style: h6Bold,
                ),
                Text(
                  'Description',
                  style: h7Regular,
                ),
                Text(
                  'Author',
                  style: h6Medium,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
