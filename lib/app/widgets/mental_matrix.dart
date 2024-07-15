import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';

class MentalMatrix extends StatelessWidget {
  const MentalMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: border, width: 2)
        ),
        height: 83,
        width: 323,
      ),
    );
  }
}
