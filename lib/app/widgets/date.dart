import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';


class DatePicker extends StatelessWidget {
  DatePicker({super.key});

  final DatePickerController controller = Get.put(DatePickerController());
  @override
  Widget build(BuildContext context) {
    if (controller.box.read('birthdate') != null) {
      controller.selectedDate.value =
          DateTime.parse(controller.box.read('birthdate'));
    }

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
              initialDate: controller.selectedDate.value,
              firstDate: DateTime(1980, 01, 01),
              lastDate: DateTime.now(),
              confirmText: "Pilih",
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: primaryColor,
                    colorScheme: ColorScheme.light(
                      primary: primaryColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              if (!isSameDate(pickedDate, controller.selectedDate.value)) {
                controller.updateDate(pickedDate);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.selectedDate.value.toLocal()}'.split(' ')[0],
                  style: textFieldStyle,
                ),
                const Icon(Icons.keyboard_arrow_down)
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
