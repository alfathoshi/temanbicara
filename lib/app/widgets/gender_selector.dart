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

    return GestureDetector(
      onTap: () => onSelect(gender),
      child: Container(
        width: 150,
        height: 40,
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
              gender == Gender.male ? 'Pria' : 'Wanita',
              style: isSelected ? textGenderTrue : textGenderFalse,
            ),
          ],
        ),
      ),
    );
  }
}
