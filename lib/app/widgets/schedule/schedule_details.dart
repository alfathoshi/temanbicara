import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class ScheduleList extends StatefulWidget {
  final List schedule;
  final ValueChanged<Map<String, String>> onSelectionChanged;

  const ScheduleList({
    super.key,
    required this.schedule,
    required this.onSelectionChanged,
  });

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  Map<String, String> _selectedSchedule = {};

  String getDayName(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEEE').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 440,
      child: ListView.builder(
        itemCount: widget.schedule.length,
        itemBuilder: (BuildContext context, int index) {
          List scheduleDay = widget.schedule[index]['schedulesByDate'];
          String date = widget.schedule[index]['date'];
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
                      Text("${getDayName(date)}, ${date}", style: h3Bold),
                      SizedBox(height: 17),
                      Text("Available Time : ", style: h4Bold),
                      SizedBox(height: 10),
                      SizedBox(
                        height: (scheduleDay.length * 47),
                        child: ListView.builder(
                          itemCount: scheduleDay.length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            String timeSlot =
                                '${scheduleDay[idx]['start_time']} - ${scheduleDay[idx]['end_time']}';
                            bool isSelected =
                                _selectedSchedule['date'] == date &&
                                    _selectedSchedule['time'] == timeSlot;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle selection lek
                                  if (isSelected) {
                                    _selectedSchedule.clear();
                                  } else {
                                    _selectedSchedule = {
                                      'date': date,
                                      'time': timeSlot,
                                    };
                                  }
                                });
                                // katanya kasitau parent kalo ada perubahan
                                widget.onSelectionChanged(_selectedSchedule);
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
                                  color: isSelected
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
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
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
              SizedBox(height: 22),
            ],
          );
        },
      ),
    );
  }
}
