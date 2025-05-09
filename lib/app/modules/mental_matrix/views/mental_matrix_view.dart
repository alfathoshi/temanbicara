import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../report/controllers/report_controller.dart';
import '../controllers/mental_matrix_controller.dart';

class MentalMatrixView extends GetView<MentalMatrixController> {
  MentalMatrixView({super.key});
  final ReportController reportController = Get.put(ReportController());
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
            'Mental Matrix',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child: Obx(() {
          final report = controller.report.value;
          if (report == null) {
            return Center(child: const CircularProgressIndicator());
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/limiter.png",
                            scale: 2.2,
                          ),
                          sbX12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("dd MMM yyyy")
                                    .format(DateTime.now()),
                                style: h5Regular,
                              ),
                              Text(
                                reportController.title.value,
                                style: h2SemiBold,
                              ),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/lingkaranMatrix.png',
                                scale: 2,
                              ),
                              Text(
                                reportController.matrixValue.value,
                                style: h5Medium.copyWith(
                                  color: primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      sby16,
                      Divider(),
                      sby16,
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Text(
                            "Assessment",
                            style: h7SemiBold.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                      sby16,
                      Text(controller.report.value!.assessment),
                      sby8,
                    ],
                  ),
                ),
              ),
              sby16,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      blurRadius: 2,
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Text(
                            "Observation",
                            style: h7SemiBold.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                      sby24,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: border,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          color: lightYellow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.yellow),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset(
                                        "assets/images/moodSmile.png",
                                        scale: 1.5,
                                      ),
                                    ),
                                  ),
                                  sbX12,
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mood Tracker",
                                          style: h4SemiBold,
                                        ),
                                        Text(
                                          controller
                                                  .report.value?.moodTracking ??
                                              'Loading...',
                                          style: h5Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/${controller.getIndexedImage(
                                      value:
                                          controller.report.value?.moodTracking,
                                      referenceList: controller.emotions,
                                      prefix: 'emosi',
                                    )}",
                                    scale: 7,
                                  ),
                                ],
                              ),
                              sby16,
                              Text(
                                controller.report.value!.mood,
                                style: h5Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sby16,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: border,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          color: lightPurple.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: lightPurple),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        "assets/images/sleepquality.png",
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  sbX12,
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sleep Quality",
                                          style: h4SemiBold,
                                        ),
                                        Text(
                                          controller
                                                  .report.value?.bedTracking ??
                                              'Loading...',
                                          style: h5Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/${controller.getIndexedImage(
                                      value:
                                          controller.report.value?.bedTracking,
                                      referenceList: controller.sleepQuality,
                                      prefix: 'sleep',
                                    )}",
                                    scale: 1.7,
                                  ),
                                ],
                              ),
                              sby16,
                              Text(
                                controller.report.value!.sleep,
                                style: h5Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sby16,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: border,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        "assets/images/strees.png",
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  sbX12,
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stress Level",
                                          style: h4SemiBold,
                                        ),
                                        Text(
                                          "Level ${controller.report.value?.stressTracking.toString()}",
                                          style: h5Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    controller.report.value?.stressTracking
                                            .toString() ??
                                        'Loading...',
                                    style: h1SemiBold.copyWith(fontSize: 48),
                                  ),
                                ],
                              ),
                              sby16,
                              Text(
                                controller.report.value!.stress,
                                style: h5Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sby16,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: border,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          color: lightPink.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: lightPink),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        "assets/images/screen.png",
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  sbX12,
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Screen Time",
                                          style: h4SemiBold,
                                        ),
                                        Text(
                                          controller.report.value
                                                  ?.screenTracking ??
                                              'Loading...',
                                          style: h5Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/${controller.getIndexedImage(
                                      value: controller
                                          .report.value?.screenTracking,
                                      referenceList: controller.ScreenTime,
                                      prefix: 'screen',
                                    )}",
                                    scale: 2,
                                  ),
                                ],
                              ),
                              sby16,
                              Text(
                                controller.report.value!.screenTime,
                                style: h5Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sby16,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: border,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          color: orange.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: orange),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(
                                        "assets/images/activity.png",
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  sbX12,
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Activity",
                                          style: h4SemiBold,
                                        ),
                                        Text(
                                          controller.report.value
                                                  ?.activityTracking
                                                  .replaceAll('\n', ' ') ??
                                              'Loading...',
                                          style: h5Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/${controller.getIndexedImage(
                                      value: controller
                                          .report.value?.activityTracking,
                                      referenceList: controller.Activity,
                                      prefix: 'step',
                                    )}",
                                    scale: 1.5,
                                  ),
                                ],
                              ),
                              sby16,
                              Text(
                                controller.report.value!.activity,
                                style: h5Regular,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sby16,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Text(
                            "Recommendations",
                            style: h7SemiBold.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                      sby24,
                      Text("Short Term", style: h3SemiBold),
                      SizedBox(height: 8),
                      ...report.shortTerm.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sbx8,
                              Text("•  ", style: h6Regular),
                              Expanded(child: Text(item, style: h6Regular)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Long Term", style: h3SemiBold),
                      SizedBox(height: 8),
                      ...report.longTerm.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sbx8,
                              Text("•  ", style: h6Regular),
                              Expanded(child: Text(item, style: h6Regular)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sby16,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Text(
                            "Closing",
                            style: h7SemiBold.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                      sby24,
                      Text(report.closing, style: h6Regular),
                      sby16,
                    ],
                  ),
                ),
              ),
            ],
          );
        })));
  }
}

// Obx(
//         () {
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final report = controller.report.value;
//           // controller.getReport();
//           if (report == null) return Center(child: Text("No data"));
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//             child: ListView(
//               children: [
//                 Text("🧠 Mood:\n${report.mood}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("😴 Sleep:\n${report.sleep}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("💥 Stress:\n${report.stress}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("📱 Screen Time:\n${report.screenTime}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("🏃 Activity:\n${report.activity}",
//                     style: TextStyle(fontSize: 16)),
//                 Divider(height: 30),
//                 Text("📋 Matrix:\n${report.matrix}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("📋 Assessment:\n${report.assessment}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("✅ Closing:\n${report.closing}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 20),
//                 Text("🎯 Short Term Goals:",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ...report.shortTerm.map((item) => ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: Icon(Icons.check, size: 20),
//                       title: Text(item, style: TextStyle(fontSize: 15)),
//                     )),
//                 SizedBox(height: 20),
//                 Text("🏁 Long Term Goals:",
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ...report.longTerm.map(
//                   (item) => ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: Icon(Icons.flag, size: 20),
//                     title: Text(item, style: TextStyle(fontSize: 15)),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
