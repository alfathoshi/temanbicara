// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/consult/controllers/consult_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = <String>[].obs;
    final List<String> categories = [
      'Work',
      'School',
      'Relationship',
      'Emotion',
      'Lonely',
      'Anxiety',
      'Social',
      'Others'
    ];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Expertise", style: h5Bold),
            ),
            sby16,
            Obx(() => Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: categories.map((item) {
                    final isSelected = selected.contains(item);
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selected.remove(item);
                        } else {
                          selected.add(item);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor
                              : grey5Color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item,
                          style: h6SemiBold.copyWith(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
            sby24,
            MyButton(
              get: () {
                final controller = Get.find<ConsultController>();
                controller.selectedExpertise.value = selected;
                Get.back();
              },
              color: primaryColor,
              text: "Filter",
            ),
          ],
        ),
      ),
    );
  }
}
