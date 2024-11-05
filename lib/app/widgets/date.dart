import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../modules/assesment_1/controllers/assesment_1_controller.dart';

class date extends StatelessWidget {
  date({super.key});

  final Assesment1Controller _assesment1controller =
      Get.put(Assesment1Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black26,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _assesment1controller.selectedDate.value,
              firstDate: DateTime(1980, 01, 01),
              lastDate: DateTime(2030, 3, 14),
              confirmText: "Pilih",
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                        primaryColor, 
                    colorScheme: ColorScheme.light(
                      primary: primaryColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              if (!isSameDate(
                  pickedDate, _assesment1controller.selectedDate.value)) {
                _assesment1controller.updateDate(pickedDate);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_assesment1controller.selectedDate.value.toLocal()}'
                      .split(' ')[0],
                  style: textFieldStyle, 
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
