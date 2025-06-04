import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class SelectDate extends StatelessWidget {
  final void Function(DateTime) onDateSelected;

  const SelectDate({super.key, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    final DatePickerController controller = Get.put(DatePickerController());

    return Obx(() {
      return EasyTheme(
        data: EasyTheme.of(context).copyWith(
          dayBottomElementStyle: WidgetStateProperty.all(h5SemiBold),
          currentDayBottomElementStyle: WidgetStateProperty.all(h5SemiBold),
          dayMiddleElementStyle: WidgetStateProperty.all(h1Bold),
          currentDayMiddleElementStyle: WidgetStateProperty.all(h1Bold),
          dayTopElementStyle: WidgetStateProperty.all(h4SemiBold),
          currentDayTopElementStyle: WidgetStateProperty.all(h4SemiBold),
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return whiteColor;
            } else if (states.contains(WidgetState.disabled)) {
              return black;
            }
            return black;
          }),
          currentDayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return whiteColor;
            } else if (states.contains(WidgetState.disabled)) {
              return black;
            }
            return black;
          }),
          dayBorder: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return BorderSide(color: primaryColor);
            } else if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: grey4Color);
            }
            return const BorderSide(color: grey4Color);
          }),
          dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            } else if (states.contains(WidgetState.disabled)) {
              return grey4Color.withValues(alpha: 0.1);
            }
            return whiteColor;
          }),
          currentDayBorder: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return BorderSide(color: primaryColor);
            } else if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: grey4Color);
            }
            return const BorderSide(color: grey4Color);
          }),
          currentDayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            } else if (states.contains(WidgetState.disabled)) {
              return grey4Color.withValues(alpha: 0.1);
            }
            return whiteColor;
          }),
        ),
        child: EasyDateTimeLinePicker(
          firstDate: DateTime.now().add(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 7)),
          focusedDate: controller.selectedDate.value,
          onDateChange: (date) {
            controller.updateDate(date);
            onDateSelected(date);
          },
          headerOptions: const HeaderOptions(
            headerType: HeaderType.none,
          ),
        ),
      );
    });
  }
}

class DatePickerController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  DateTime get currentSelectedDate => selectedDate.value;
}
