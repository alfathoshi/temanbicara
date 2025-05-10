// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/consult_schedule/controllers/consult_schedule_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class ScheduleController extends GetxController {
  final Rx<Map<String, dynamic>> selectedSchedule =
      Rx<Map<String, dynamic>>({});
  final ValueChanged<Map<String, dynamic>> onSelectionChanged;

  ScheduleController({required this.onSelectionChanged});

  void toggleSelection(String date, String timeSlot, int id) {
    if (selectedSchedule.value['date'] == date &&
        selectedSchedule.value['time'] == timeSlot) {
      selectedSchedule.value = {};
    } else {
      selectedSchedule.value = {
        'date': date,
        'time': timeSlot,
        'id': id,
      };
    }
    onSelectionChanged(selectedSchedule.value);
  }

  bool isSelected(String date, String timeSlot) {
    return selectedSchedule.value['date'] == date &&
        selectedSchedule.value['time'] == timeSlot;
  }

  String getDayName(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEEE').format(dateTime);
  }
}

class ScheduleList extends StatelessWidget {
  final List schedule;
  final Rx<DateTime> selectedDate;

  const ScheduleList({
    Key? key,
    required this.schedule,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConsultScheduleController>();

    return Obx(() {
      final selectedDateStr =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);

      final daySchedule = schedule.firstWhere(
        (e) => e['date'] == selectedDateStr,
        orElse: () => null,
      );

      if (daySchedule == null) {
        return Column(
          children: [
            Center(
              child: Image.asset(
                "assets/images/noDate.png",
              ),
            ),
            sby12,
            Center(
              child: Text(
                "No schedule available for this date",
                style: h5SemiBold,
              ),
            ),
          ],
        );
      }

      List scheduleDay = daySchedule['schedulesByDate'];

      return Align(
        alignment: Alignment.topLeft,
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: scheduleDay.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 10,
              childAspectRatio: 3.3,
            ),
            itemBuilder: (ctx, idx) {
              int id = scheduleDay[idx]['schedule_id'];
              String startTime = DateFormat('HH:mm').format(
                DateFormat('HH:mm:ss').parse(scheduleDay[idx]['start_time']),
              );
              String endTime = DateFormat('HH:mm').format(
                DateFormat('HH:mm:ss').parse(scheduleDay[idx]['end_time']),
              );
              String timeSlot = '$startTime - $endTime';
              String selectedDateStr =
                  DateFormat('yyyy-MM-dd').format(selectedDate.value);

              return Obx(() {
                final isSelected = controller.selectedSchedule.value['date'] ==
                        selectedDateStr &&
                    controller.selectedSchedule.value['time'] == timeSlot;

                return GestureDetector(
                  onTap: () {
                    controller.updateSelectedSchedule({
                      'date': selectedDateStr,
                      'time': timeSlot,
                      'id': id,
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color:
                            isSelected ? primaryColor : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                      color: isSelected ? primaryColor : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      timeSlot,
                      style: h7Bold.copyWith(
                        fontSize: 16,
                        color:
                            isSelected ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                );
              });
            }),
      );
    });
  }
}
