import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/custom_bar_chart.dart';

import '../controllers/mood_report_controller.dart';

class MoodReportView extends GetView<MoodReportController> {
  const MoodReportView({super.key});
  @override
  Widget build(BuildContext context) {
    SlidingUpPanelController slidingUpController = SlidingUpPanelController();
    List<dynamic> dummyData = [
      {"month": "Dec", "date": "31", "sleep_hours": 20},
      {"month": "Dec", "date": "30", "sleep_hours": 5},
      {"month": "Dec", "date": "29", "sleep_hours": 4},
      {"month": "Dec", "date": "28", "sleep_hours": 5},
      {"month": "Dec", "date": "27", "sleep_hours": 8},
    ];
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Mood',
              style: h2Bold,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
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
                    child: Image.asset("assets/images/emosi4.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Happy",
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
                physics: const NeverScrollableScrollPhysics(),
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
                    "Mood History",
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for (int i = 0; i < 5; i++)
                    MoodHistoryItem(
                      category: "Happy",
                      date: "1",
                      month: "Des",
                      image: "assets/images/emosi1.png",
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MoodHistoryItem extends StatelessWidget {
  final String category;
  final String date;
  final String month;
  final String image;
  const MoodHistoryItem(
      {super.key,
      required this.category,
      required this.date,
      required this.month,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF9AD567).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBDCF99),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFBDCF99),
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
                        month,
                        style: h6Medium,
                      ),
                      Text(
                        date,
                        style: h4Bold,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  category,
                  style: h4Bold,
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 53,
              height: 53,
              child: Image.asset(
                image,
              ),
            )
          ],
        ),
      ),
    );
  }
}
