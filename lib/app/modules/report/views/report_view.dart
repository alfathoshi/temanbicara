import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temanbicara/app/modules/mental_matrix/controllers/mental_matrix_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/report/report_matrix.dart';
import '../../../widgets/date.dart';
import '../../../widgets/report/pie_chart_report.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  Widget _buildPieChartCardShimmer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: border,
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 150.0, height: 20.0, color: Colors.white),
              const SizedBox(height: 8),
              Container(width: 200.0, height: 16.0, color: Colors.white),
              sby24,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  sby24,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          width: double.infinity,
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStressGaugeCardShimmer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: border,
            offset: const Offset(0, 1),
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
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 120, height: 24.0, color: Colors.white),
              const SizedBox(height: 8),
              Container(width: 180, height: 18.0, color: Colors.white),
              sby16,
              AspectRatio(
                aspectRatio: 1.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMentalMatrixShimmer(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: border,
              width: 1,
            ),
          ),
          height: 83,
          width: MediaQuery.sizeOf(context).width,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Mental Report",
          style: h3Bold,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchStatistik();
          controller.checkTracking();
        },
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: border,
                    offset: const Offset(0, 1),
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
                        Expanded(
                          child: Text(
                            "Mental Health Tracker",
                            style: h6Medium,
                          ),
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(formatDate(controller.selectedDate.value)),
                              sbx8,
                              FlexibleDatePicker(
                                selectedDate: controller.selectedDate.value,
                                isIconOnly: true,
                                onDateChanged: (pickedDate) async {
                                  bool success = await controller.getMatrix(
                                      dateToFetch: pickedDate);
                                  if (success) {
                                    controller.updateDate(pickedDate);
                                    controller.checkTracking();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return _buildMentalMatrixShimmer(context);
                      } else {
                        return ReportMatrix(
                          onPressed: () {
                            Get.toNamed(Routes.MENTAL_MATRIX);
                          },
                          title: "Mental Health Matrix",
                          description: controller.title.value,
                          image: "assets/images/limiter.png",
                          matrixValue: controller.matrixValue.value,
                          color: lightGreen,
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            sby24,
            Obx(() {
              final dataList = controller.trackingList['tracking_data'] ?? [];
              if (controller.isFetching.value) {
                return _buildPieChartCardShimmer();
              }
              if (dataList.isEmpty) return const Text("No mood data found");

              final moodCounts = {for (var m in controller.emotions) m: 0};
              for (final item in dataList) {
                final category = item['mood_level'].toString().trim();
                if (moodCounts.containsKey(category)) {
                  moodCounts[category] = moodCounts[category]! + 1;
                }
              }
              return PieChartCard(
                title: "Mood Statistik",
                subtitle: "Your mood trends",
                categories: controller.emotions,
                dataCounts: moodCounts,
                chartColors: controller.chartColors,
                touchedIndex: controller.touchedIndexMood.value,
                onTouch: (i) => controller.touchedIndexMood.value = i,
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/${MentalMatrixController().getIndexedImage(
                        value: controller.avgMood.value,
                        referenceList: controller.emotions,
                        prefix: 'emosi',
                      )}",
                      scale: 15,
                    ),
                    Text(controller.avgMood.value, style: h7SemiBold),
                  ],
                ),
              );
            }),
            sby24,
            Obx(() {
              final dataList = controller.trackingList['tracking_data'] ?? [];
              if (controller.isFetching.value) {
                return _buildPieChartCardShimmer();
              }
              if (dataList.isEmpty) return const Text("No sleep data found");

              final sleepCounts = {for (var m in controller.sleepQuality) m: 0};
              for (final item in dataList) {
                final category = item['bed_time'].toString().trim();
                if (sleepCounts.containsKey(category)) {
                  sleepCounts[category] = sleepCounts[category]! + 1;
                }
              }
              return PieChartCard(
                title: "Sleep Quality",
                subtitle: "Your sleep trends and quality",
                categories: controller.sleepQuality,
                dataCounts: sleepCounts,
                chartColors: controller.chartColors,
                touchedIndex: controller.touchedIndexSleep.value,
                onTouch: (i) => controller.touchedIndexSleep.value = i,
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.avgSleep.value, style: h5SemiBold),
                    const Text("average",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              );
            }),
            sby24,
            Obx(() {
              final dataList = controller.trackingList['tracking_data'] ?? [];
              if (controller.isFetching.value) {
                return _buildStressGaugeCardShimmer();
              }

              if (dataList.isEmpty) {
                return const Text("No stress data found");
              }

              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      offset: const Offset(0, 1),
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
                        "Stress Level",
                        style: h4SemiBold,
                      ),
                      Text(
                        "Your average stress lately",
                        style: h6Regular,
                      ),
                      sby16,
                      AspectRatio(
                        aspectRatio: 1.6,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 5,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Colors.grey.shade200,
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: controller.avgStress.value.toDouble(),
                                  cornerStyle: CornerStyle.bothCurve,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: primaryColor,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          controller.avgStress.value.toString(),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  angle: 90,
                                  positionFactor: 0,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            sby24,
            Obx(() {
              final dataList = controller.trackingList['tracking_data'] ?? [];
              if (controller.isFetching.value) {
                return _buildPieChartCardShimmer();
              }
              if (dataList.isEmpty) return const Text("No activity data found");

              final activityCounts = {for (var m in controller.activity) m: 0};
              for (final item in dataList) {
                final category = item['activity'].toString().trim();
                if (activityCounts.containsKey(category)) {
                  activityCounts[category] = activityCounts[category]! + 1;
                }
              }
              return PieChartCard(
                title: "Activity Balance",
                subtitle: "How active or restful your days have been",
                categories: controller.activity,
                dataCounts: activityCounts,
                chartColors: controller.chartColors,
                touchedIndex: controller.touchedIndexActivity.value,
                onTouch: (i) => controller.touchedIndexActivity.value = i,
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.avgActivity.value, style: h5SemiBold),
                    const Text("average",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              );
            }),
            sby24,
            Obx(() {
              final dataList = controller.trackingList['tracking_data'] ?? [];
              if (controller.isFetching.value) {
                return _buildPieChartCardShimmer();
              }
              if (dataList.isEmpty) return const Text("No screen data found");

              final screenCounts = {for (var m in controller.screenTime) m: 0};
              for (final item in dataList) {
                final category = item['screen_time'].toString().trim();
                if (screenCounts.containsKey(category)) {
                  screenCounts[category] = screenCounts[category]! + 1;
                }
              }
              return PieChartCard(
                title: "Screen Time",
                subtitle: "Your spending time on gadget",
                categories: controller.screenTime,
                dataCounts: screenCounts,
                chartColors: controller.chartColors,
                touchedIndex: controller.touchedIndexScreen.value,
                onTouch: (i) => controller.touchedIndexScreen.value = i,
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.avgScreen.value, style: h5SemiBold),
                    const Text("average",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              );
            }),
            sby24,
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
                  onPressed: () {},
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
