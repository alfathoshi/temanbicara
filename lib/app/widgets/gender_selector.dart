import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../modules/assesment_1/controllers/assesment_1_controller.dart';

class GenderSelector extends StatelessWidget {
  final Gender gender;
  final Gender selectedGender;
  final Function(Gender) onSelect;

  const GenderSelector({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedGender == gender;
    final size = MediaQuery.of(context).size;
  
    final double width = size.width * 0.375;
    final double height = size.height * 0.05;

    return GestureDetector(
      onTap: () => onSelect(gender),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : whiteColor,
          border: isSelected ? null : Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              gender == Gender.male
                  ? 'assets/icons/male.png'
                  : 'assets/icons/female.png',
              scale: 2,
              color: isSelected ? whiteColor : null,
            ),
            const SizedBox(width: 8),
            Text(
              gender == Gender.male ? 'Male' : 'Female',
              style: isSelected ? textGenderTrue : textGenderFalse,
            ),
          ],
        ),
      ),
    );
  }
}
