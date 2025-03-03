import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
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
  final ValueChanged<Map<String, dynamic>> onSelectionChanged;

  const ScheduleList({
    Key? key,
    required this.schedule,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(ScheduleController(onSelectionChanged: onSelectionChanged));
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 350,
      child: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (BuildContext context, int index) {
          List scheduleDay = schedule[index]['schedulesByDate'];
          String date = schedule[index]['date'];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(9, 30, 66, 0.25),
                      blurRadius: 8,
                      spreadRadius: -2,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(9, 30, 66, 0.08),
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${controller.getDayName(date)}, ${date}",
                          style: h3Bold),
                      sby16,
                      Text("Available Time : ", style: h4Bold),
                      sby12,
                      SizedBox(
                        height: (scheduleDay.length * 47),
                        child: ListView.builder(
                          itemCount: scheduleDay.length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            int id = scheduleDay[idx]['schedule_id'];
                            String timeSlot =
                                '${scheduleDay[idx]['start_time']} - ${scheduleDay[idx]['end_time']}';

                            return GetX<ScheduleController>(
                              builder: (ctrl) => GestureDetector(
                                onTap: () {
                                  ctrl.toggleSelection(date, timeSlot, id);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth / 2.2, bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color(0xFF7D944D),
                                      width: 1.5,
                                    ),
                                    color: ctrl.isSelected(date, timeSlot)
                                        ? Color(0xFF7D944D)
                                        : Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    child: Text(
                                      timeSlot,
                                      style: h7Bold.copyWith(
                                        fontSize: 12,
                                        color: ctrl.isSelected(date, timeSlot)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sby24,
            ],
          );
        },
      ),
    );
  }
}
