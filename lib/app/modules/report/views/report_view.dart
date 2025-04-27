import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: GestureDetector(
          onTap: () {
            print(controller.trackingList);
          },
          child: Text(
            'Mental Report',
            style: h3Bold,
          ),
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
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ReportCategory(
              onPressed: () {
                controller.trackingList.isEmpty
                    ? Get.snackbar(
                        "Tidak dapat mengakses halaman",
                        "Data tracking anda masih kosong. Silahkan melakukan tracking",
                        backgroundColor: error.withOpacity(0.6),
                        colorText: Colors.white,
                      )
                    : Get.toNamed(Routes.SLEEP_QUALITY, arguments: [
                        controller.trackingList,
                        controller.avgSleep
                      ]);
              },
              title: "Sleep Quality",
              description: "Status ${controller.avgSleep.value}",
              image: "assets/images/sleepquality.png",
            ),
            ReportCategory(
              onPressed: () {
                controller.trackingList.isEmpty
                    ? Get.snackbar(
                        "Tidak dapat mengakses halaman",
                        "Data tracking anda masih kosong. Silahkan melakukan tracking",
                        backgroundColor: error.withOpacity(0.6),
                        colorText: Colors.white,
                      )
                    : Get.toNamed(Routes.STRESS_LEVEL, arguments: [
                        controller.trackingList,
                        controller.avgStress
                      ]);
              },
              title: "Stress Level",
              description: "Level ${controller.avgStress.value}",
              image: "assets/images/stresslevel.png",
            ),
            ReportCategory(
              onPressed: () {
                controller.trackingList.isEmpty
                    ? Get.snackbar(
                        "Tidak dapat mengakses halaman",
                        "Data tracking anda masih kosong. Silahkan melakukan tracking",
                        backgroundColor: error.withOpacity(0.6),
                        colorText: Colors.white,
                      )
                    : Get.toNamed(Routes.MOOD_REPORT, arguments: [
                        controller.trackingList,
                        controller.avgMood
                      ]);
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
                    // Get.toNamed(Routes.CONSULTATION);
                    print(controller.trackingList);
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
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
