import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/report/observation_card.dart';
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
          final report = reportController.report.value;
          if (report == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: const Offset(0, 1),
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
                                controller
                                    .formatDate(
                                        reportController.selectedDate.value)
                                    .toString(),
                                style: h5Regular,
                              ),
                              Text(
                                reportController.title.value,
                                style: h2SemiBold,
                              ),
                            ],
                          ),
                          const Spacer(),
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
                      const Divider(),
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
                      Text(reportController.report.value!.assessment),
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
                      ObservationCard(
                        backgroundColor: lightYellow,
                        iconBackgroundColor: Colors.yellow,
                        iconAsset: "assets/images/moodSmile.png",
                        iconScale: 1.5,
                        title: "Mood Tracker",
                        value: reportController.report.value?.moodTracking,
                        description: reportController.report.value!.mood,
                        scale: 7,
                        indicatorAsset:
                            "assets/images/${controller.getIndexedImage(
                          value: reportController.report.value?.moodTracking,
                          referenceList: controller.emotions,
                          prefix: 'emosi',
                        )}",
                      ),
                      sby16,
                      ObservationCard(
                        backgroundColor: lightPurple.withValues(alpha: 0.5),
                        iconBackgroundColor: lightPurple,
                        iconAsset: "assets/images/sleepquality.png",
                        iconScale: 2,
                        title: "Sleep Quality",
                        value: reportController.report.value?.bedTracking,
                        description: reportController.report.value!.sleep,
                        scale: 1.7,
                        indicatorAsset:
                            "assets/images/${controller.getIndexedImage(
                          value: reportController.report.value?.bedTracking,
                          referenceList: controller.sleepQuality,
                          prefix: 'sleep',
                        )}",
                      ),
                      sby16,
                      ObservationCard(
                        backgroundColor: lightBlue,
                        iconBackgroundColor: Colors.blue,
                        iconAsset: "assets/images/strees.png",
                        iconScale: 2,
                        title: "Stress Level",
                        value:
                            "Level ${reportController.report.value?.stressTracking}",
                        description: reportController.report.value!.stress,
                        scale: 2,
                        indicatorText: Text(
                          reportController.report.value?.stressTracking
                                  .toString() ??
                              'Loading...',
                          style: h1SemiBold.copyWith(fontSize: 48),
                        ),
                      ),
                      sby16,
                      ObservationCard(
                        backgroundColor: lightPink.withValues(alpha: 0.5),
                        iconBackgroundColor: lightPink,
                        iconAsset: "assets/images/screen.png",
                        iconScale: 2,
                        title: "Screen Time",
                        value: reportController.report.value?.screenTracking,
                        description: reportController.report.value!.screenTime,
                        scale: 2,
                        indicatorAsset:
                            "assets/images/${controller.getIndexedImage(
                          value: reportController.report.value?.screenTracking,
                          referenceList: controller.screenTime,
                          prefix: 'screen',
                        )}",
                      ),
                      sby16,
                      ObservationCard(
                        backgroundColor: orange.withValues(alpha: 0.25),
                        iconBackgroundColor: orange,
                        iconAsset: "assets/images/activity.png",
                        iconScale: 2,
                        title: "Activity",
                        value: reportController.report.value?.activityTracking,
                        description: reportController.report.value!.activity,
                        scale: 1.5,
                        indicatorAsset:
                            "assets/images/${controller.getIndexedImage(
                          value:
                              reportController.report.value?.activityTracking,
                          referenceList: controller.activity,
                          prefix: 'step',
                        )}",
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
                      offset: const Offset(0, 1),
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 16),
                      Text("Long Term", style: h3SemiBold),
                      const SizedBox(height: 8),
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
                      offset: const Offset(0, 1),
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
