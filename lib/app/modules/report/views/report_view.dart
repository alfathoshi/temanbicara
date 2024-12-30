import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();

    Future<void> selectDate() async {
      DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (date != null) {}
    }

    return Scaffold(
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
          'Mental Report',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mental Health Tracker",
                  style: h4Medium,
                ),
                SizedBox(
                  width: 150,
                  height: 25,
                  child: TextField(
                    controller: dateController,
                    onTap: () {
                      selectDate();
                    },
                    readOnly: true,
                    style: h5Regular,
                    decoration: const InputDecoration(
                      hintText: "12 Desember 2024",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ReportCategory(
              onPressed: () {
                Get.toNamed(Routes.SLEEP_QUALITY,
                    arguments: [controller.trackingList, controller.avgSleep]);
              },
              title: "Sleep Quality",
              description: "Status ${controller.avgSleep.value}",
              image: "assets/images/sleepquality.png",
            ),
            ReportCategory(
              onPressed: () {
                Get.toNamed(Routes.STRESS_LEVEL,
                    arguments: [controller.trackingList, controller.avgStress]);
              },
              title: "Stress Level",
              description: "Level ${controller.avgStress.value}",
              image: "assets/images/stresslevel.png",
            ),
            ReportCategory(
              onPressed: () {
                Get.toNamed(Routes.MOOD_REPORT,
                    arguments: [controller.trackingList, controller.avgMood]);
              },
              title: "Mood Tracker",
              description: "Status ${controller.avgMood.value}",
              image: "assets/images/moodtracker.png",
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Need an Expert?",
                style: h5Bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/therapist_1.png"),
            Column(
              children: [
                Text(
                  "Nearest mental health services:  ",
                  style: h5Regular,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.CONSULTATION);
                  },
                  child: Text(
                    "Click Here",
                    style: h5Regular.copyWith(color: Colors.blue),
                  ),
                ),
                Text(
                  "Ministry of Health Mental Health Hotline",
                  style: h5Regular,
                ),
                TextButton(
                  onPressed: () {
                    print("pressed");
                  },
                  child: Text(
                    "021-500-454",
                    style: h5Regular.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReportCategory extends StatelessWidget {
  final String image;
  final Function onPressed;
  final String title;
  final String description;

  const ReportCategory(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      height: 83,
      decoration: BoxDecoration(
        color: const Color(0xFFBDCF99).withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBDCF99).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDCF99),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFBDCF99),
                          spreadRadius: 1,
                          blurRadius: 0.5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      image,
                      scale: 1.5,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: h5Bold,
                      ),
                      Text(
                        description,
                        style: h5Regular,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
