import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
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
        title: Text(
          'Mental Report',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getMatrix();
        },
        child: Container(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mental Health Tracker",
                            style: h6Medium,
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined),
                              Text(
                                DateFormat('dd MMM yyyy')
                                    .format(DateTime.now()),
                                style: h5Regular,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReportCategory(
                        onPressed: () {
                          // Get.snackbar(
                          //       "Tidak dapat mengakses halaman",
                          //       "Data tracking anda masih kosong. Silahkan melakukan tracking",
                          //       backgroundColor: error.withOpacity(0.6),
                          //       colorText: Colors.white,
                          //     ) ??
                          Get.toNamed(Routes.MENTAL_MATRIX);
                        },
                        title: "Mental Health Matrix",
                        description: controller.title.value,
                        image: "assets/images/limiter.png",
                        matrixValue: controller.matrixValue.value,
                        color: lightGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mood Statistics",
                        style: h4SemiBold,
                      ),
                      Text(
                        "How you’ve been feeling lately",
                        style: h6Regular,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}

class ReportCategory extends StatelessWidget {
  final String image;
  final Function onPressed;
  final String title;
  final String description;
  final String matrixValue;
  final Color color;

  const ReportCategory(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.description,
      required this.image,
      required this.matrixValue,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      height: 83,
      decoration: BoxDecoration(
        color: color,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    scale: 2.5,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: h6Bold,
                      ),
                      Text(
                        description,
                        style: h5Regular,
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/lingkaranMatrix.png',
                    scale: 2,
                  ),
                  Text(
                    matrixValue,
                    style: h5Medium.copyWith(
                      color: primaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
