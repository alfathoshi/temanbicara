import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class FlexibleDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateChanged;

  final bool isIconOnly;
  final String? placeholder;

  const FlexibleDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.isIconOnly = false,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (isSameDate(selectedDate, DateTime.now())) {
      displayText = placeholder ?? "Choose";
    } else {
      displayText = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1980, 1, 1),
          lastDate: DateTime.now(),
          confirmText: "Ok",
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

        if (pickedDate != null && !isSameDate(pickedDate, selectedDate)) {
          onDateChanged(pickedDate);
        }
      },
      child: isIconOnly
          ? const Icon(Icons.calendar_month_outlined)
          : Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: border,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayText,
                    style: isSameDate(selectedDate, DateTime.now())
                        ? h5Regular.copyWith(color: greyColor)
                        : h6Regular,
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
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
