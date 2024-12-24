import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class ScheduleList extends StatelessWidget {
  final List schedule;

  const ScheduleList({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    // int totalScheduleDayLength = schedule.fold(0, (sum, item) {
    //   List scheduleDays = item['schedules'];
    //   return sum + scheduleDays.length;
    // });

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 440,
      child: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (BuildContext context, int index) {
          List scheduleDay = schedule[index]['schedules'];
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
                      offset: Offset(
                        0,
                        4,
                      ),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(9, 30, 66, 0.08),
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(
                        0,
                        0,
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(schedule[index]['date'], style: h3Bold),
                      SizedBox(height: 17),
                      Text("Available Time : ", style: h4Bold),
                      SizedBox(height: 10),
                      SizedBox(
                        height: (scheduleDay.length * 47),
                        child: ListView.builder(
                            itemCount: scheduleDay.length,
                            itemBuilder: (BuildContext ctx, int idx) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right: screenWidth / 2.2, bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Color(0xFF7D944D), width: 1.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Text(
                                    '${scheduleDay[idx]['start_time']} - ${scheduleDay[idx]['end_time']}',
                                    style: h7Bold.copyWith(fontSize: 12),
                                  ),
                                ),
                              );
                            }),
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
