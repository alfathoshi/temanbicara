import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/report/logo_helper.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/custom_bar_chart.dart';

import '../controllers/sleep_quality_controller.dart';

class SleepQualityView extends GetView<SleepQualityController> {
  const SleepQualityView({super.key});
  @override
  Widget build(BuildContext context) {
    List<dynamic> dummyData = [
      {"month": "Dec", "date": "31", "sleep_hours": 20},
      {"month": "Dec", "date": "30", "sleep_hours": 5},
      {"month": "Dec", "date": "29", "sleep_hours": 4},
      {"month": "Dec", "date": "28", "sleep_hours": 5},
      {"month": "Dec", "date": "27", "sleep_hours": 8},
    ];

    List<dynamic> trackingList = Get.arguments[0].value;

    SlidingUpPanelController slidingUpController = SlidingUpPanelController();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            toolbarHeight: 85,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12),
            ),
            title: Text(
              'Sleep Quality',
              style: h3Bold,
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 147,
                    width: 153,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox.square(
                          dimension: 120,
                          child: CircularProgressIndicator(
                            value: 30,
                            color: Color(0xFFF9C200),
                            strokeWidth: 10,
                          ),
                        ),
                        Image.asset(LogoHelper.sleepQuality[Get.arguments[1]]!),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Get.arguments[1].value,
                    style: h1Bold.copyWith(color: const Color(0xFFFEBE58)),
                  ),
                  Image.asset(
                    "assets/images/happy_bg.png",
                  ),
                ],
              ),
            ),
          ),
        ),
        SlidingUpPanelWidget(
          upperBound: 1.1,
          controlHeight: 450,
          panelController: slidingUpController,
          anchor: 0.7,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
              child: ListView(
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sleep Statistics",
                    style: h3Bold,
                  ),
                  Text(
                    "Istirahat adalah investasi kesehatan. Jangan lupa tidur cukup malam ini!",
                    style: h4Regular,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Sleep History",
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBarChart(
                    dummyData: trackingList,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < trackingList.length; i++)
                    SleepHistoryItem(
                      description: trackingList[i]['sleep_quality'],
                      date: trackingList[i]['updated_at']
                          .split('T')[0]
                          .toString(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SleepHistoryItem extends StatelessWidget {
  final String description;
  final String date;
  const SleepHistoryItem(
      {super.key, required this.description, required this.date});

  @override
  Widget build(BuildContext context) {
    List month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 253, 214, 151),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFEBE58),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFFEBE58),
                    spreadRadius: 1,
                    blurRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    month[int.parse(date.split('-')[1]) - 1],
                    style: h6Medium,
                  ),
                  Text(
                    date.split('-')[2],
                    style: h4Bold,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Kualitas tidur kamu \"$description\"",
              style: h4Regular,
            ),
          ],
        ),
      ),
    );
  }
}
