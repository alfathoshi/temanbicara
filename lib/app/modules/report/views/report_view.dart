import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/modules/mental_matrix/controllers/mental_matrix_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../widgets/date.dart';
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
          controller.fetchStatistik();
          controller.checkTracking();
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
                          Expanded(
                            child: Text(
                              "Mental Health Tracker",
                              style: h6Medium,
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: controller.selectedDate.value,
                                    firstDate: DateTime(2000, 01, 01),
                                    lastDate: DateTime.now(),
                                    confirmText: "Select",
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          primaryColor: primaryColor,
                                          colorScheme: ColorScheme.light(
                                            primary: primaryColor,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (pickedDate != null &&
                                      !isSameDate(pickedDate,
                                          controller.selectedDate.value)) {
                                    controller.updateDate(pickedDate);
                                    controller.getMatrix();
                                    controller.checkTracking();
                                  }
                                },
                                child:
                                    const Icon(Icons.calendar_month_outlined),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => ReportCategory(
                          onPressed: () {
                            Get.toNamed(Routes.MENTAL_MATRIX);
                          },
                          title: "Mental Health Matrix",
                          description: controller.title.value,
                          image: "assets/images/limiter.png",
                          matrixValue: controller.matrixValue.value,
                          color: lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sby24,
              Obx(() {
                final dataList = controller.trackingList['tracking_data'] ?? [];

                // print("Data List Length: ${dataList.length}");

                if (controller.isFetching.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataList.isEmpty) {
                  return Text("No mood data found");
                }

                final List<PieChartSectionData> sections = [];
                final Map<String, int> moodCounts = {
                  for (var quality in controller.emotions) quality: 0,
                };

                for (final item in dataList) {
                  final category = item['mood_level'].toString().trim();
                  // print("Bed time value: $bedTime");
                  // print("Category value: $category");
                  // print("controller value: ${controller.sleepQuality}");
                  if (moodCounts.containsKey(category)) {
                    moodCounts[category] = moodCounts[category]! + 1;
                  }
                }

                final total = moodCounts.values.reduce((a, b) => a + b);
                for (int i = 0; i < controller.emotions.length; i++) {
                  final category = controller.emotions[i];
                  final count = moodCounts[category]!;
                  final double value = total > 0 ? (count / total) * 100 : 0;
                  // print("Sleep Counts: $sleepCounts");
                  // print("Total: $total");
                  sections.add(
                    PieChartSectionData(
                      color: controller.chartColors[i],
                      value: value,
                      title: '',
                      radius: 50,
                    ),
                  );
                }

                final avgText = controller.avgMood.value;
                // print("avg text: ${avgText}");
                return Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mood Statistik",
                          style: h4SemiBold,
                        ),
                        Text(
                          "Your sleep trends and quality",
                          style: h6Regular,
                        ),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndexMood.value = -1;
                                        return;
                                      }
                                      controller.touchedIndexMood.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    },
                                  ),
                                  sections: List.generate(
                                      controller.emotions.length, (i) {
                                    final category = controller.emotions[i];
                                    final count = moodCounts[category]!;
                                    final value =
                                        total > 0 ? (count / total) * 100 : 0;
                                    final isTouched =
                                        controller.touchedIndexMood.value == i;

                                    return PieChartSectionData(
                                      color: controller.chartColors[i],
                                      value: value.toDouble(),
                                      title: isTouched
                                          ? '${value.toStringAsFixed(1)}%'
                                          : '',
                                      radius: isTouched ? 55 : 50,
                                      titleStyle: h6SemiBold,
                                    );
                                  }),
                                  centerSpaceRadius: 50,
                                  sectionsSpace: 2,
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                              Center(
                                child: Column(
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
                                    sby8,
                                    Text(avgText.toString(), style: h7SemiBold),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: List.generate(controller.emotions.length,
                                (index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: controller.chartColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  sbx5,
                                  Text(controller.emotions[index],
                                      style: h6Regular),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              sby24,
              Obx(() {
                final dataList = controller.trackingList['tracking_data'] ?? [];

                // print("Data List Length: ${dataList.length}");

                if (controller.isFetching.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataList.isEmpty) {
                  return Text("No sleep data found");
                }

                final List<PieChartSectionData> sections = [];
                final Map<String, int> sleepCounts = {
                  for (var quality in controller.sleepQuality) quality: 0,
                };

                for (final item in dataList) {
                  final category = item['bed_time'].toString().trim();
                  // print("Bed time value: $bedTime");
                  // print("Category value: $category");
                  // print("controller value: ${controller.sleepQuality}");
                  if (sleepCounts.containsKey(category)) {
                    sleepCounts[category] = sleepCounts[category]! + 1;
                  }
                }

                final total = sleepCounts.values.reduce((a, b) => a + b);
                for (int i = 0; i < controller.sleepQuality.length; i++) {
                  final category = controller.sleepQuality[i];
                  final count = sleepCounts[category]!;
                  final double value = total > 0 ? (count / total) * 100 : 0;
                  // print("Sleep Counts: $sleepCounts");
                  // print("Total: $total");
                  sections.add(
                    PieChartSectionData(
                      color: controller.chartColors[i],
                      value: value,
                      title: '',
                      radius: 50,
                    ),
                  );
                }

                final avgText = controller.avgSleep.value;
                // print("avg text: ${avgText}");
                return Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sleep Quality",
                          style: h4SemiBold,
                        ),
                        Text(
                          "Your sleep trends and quality",
                          style: h6Regular,
                        ),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndexSleep.value = -1;
                                        return;
                                      }
                                      controller.touchedIndexSleep.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    },
                                  ),
                                  sections: List.generate(
                                      controller.sleepQuality.length, (i) {
                                    final category = controller.sleepQuality[i];
                                    final count = sleepCounts[category]!;
                                    final value =
                                        total > 0 ? (count / total) * 100 : 0;
                                    final isTouched =
                                        controller.touchedIndexSleep.value == i;

                                    return PieChartSectionData(
                                      color: controller.chartColors[i],
                                      value: value.toDouble(),
                                      title: isTouched
                                          ? '${value.toStringAsFixed(1)}%'
                                          : '',
                                      radius: isTouched ? 55 : 50,
                                      titleStyle: h6SemiBold,
                                    );
                                  }),
                                  centerSpaceRadius: 50,
                                  sectionsSpace: 2,
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(avgText.toString(), style: h5SemiBold),
                                    Text("average",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: List.generate(
                                controller.sleepQuality.length, (index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: controller.chartColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  sbx5,
                                  Text(controller.sleepQuality[index],
                                      style: h6Regular),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              sby24,
              Obx(() {
                final dataList = controller.trackingList['tracking_data'] ?? [];

                // print("Data List Length: ${dataList.length}");

                if (controller.isFetching.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataList.isEmpty) {
                  return Text("No stress data found");
                }

                return Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
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
                                    value:
                                        controller.avgStress.value.toDouble(),
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
                                            controller.avgStress.value
                                                .toString(),
                                            style: TextStyle(
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

                // print("Data List Length: ${dataList.length}");

                if (controller.isFetching.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataList.isEmpty) {
                  return Text("No Activity data found");
                }

                final List<PieChartSectionData> sections = [];
                final Map<String, int> activityCounts = {
                  for (var quality in controller.Activity) quality: 0,
                };

                for (final item in dataList) {
                  final category = item['activity'].toString().trim();
                  // print("Bed time value: $bedTime");
                  // print("Category value: $category");
                  // print("controller value: ${controller.sleepQuality}");
                  if (activityCounts.containsKey(category)) {
                    activityCounts[category] = activityCounts[category]! + 1;
                  }
                }

                final total = activityCounts.values.reduce((a, b) => a + b);
                for (int i = 0; i < controller.Activity.length; i++) {
                  final category = controller.Activity[i];
                  final count = activityCounts[category]!;
                  final double value = total > 0 ? (count / total) * 100 : 0;
                  // print("Sleep Counts: $sleepCounts");
                  // print("Total: $total");
                  sections.add(
                    PieChartSectionData(
                      color: controller.chartColors[i],
                      value: value,
                      title: '',
                      radius: 50,
                    ),
                  );
                }

                final avgText = controller.avgScreen.value;
                // print("avg text: ${avgText}");
                return Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Activity Balance",
                          style: h4SemiBold,
                        ),
                        Text(
                          "How active or restful your days have been",
                          style: h6Regular,
                        ),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndexActivity.value =
                                            -1;
                                        return;
                                      }
                                      controller.touchedIndexActivity.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    },
                                  ),
                                  sections: List.generate(
                                      controller.Activity.length, (i) {
                                    final category = controller.Activity[i];
                                    final count = activityCounts[category]!;
                                    final value =
                                        total > 0 ? (count / total) * 100 : 0;
                                    final isTouched =
                                        controller.touchedIndexActivity.value ==
                                            i;

                                    return PieChartSectionData(
                                      color: controller.chartColors[i],
                                      value: value.toDouble(),
                                      title: isTouched
                                          ? '${value.toStringAsFixed(1)}%'
                                          : '',
                                      radius: isTouched ? 55 : 50,
                                      titleStyle: h6SemiBold,
                                    );
                                  }),
                                  centerSpaceRadius: 50,
                                  sectionsSpace: 2,
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(avgText.toString(), style: h5SemiBold),
                                    Text("average",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: List.generate(controller.Activity.length,
                                (index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: controller.chartColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  sbx5,
                                  Text(controller.Activity[index],
                                      style: h6Regular),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              sby24,
              Obx(() {
                final dataList = controller.trackingList['tracking_data'] ?? [];

                // print("Data List Length: ${dataList.length}");

                if (controller.isFetching.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataList.isEmpty) {
                  return Text("No Screen data found");
                }

                final List<PieChartSectionData> sections = [];
                final Map<String, int> screenCounts = {
                  for (var quality in controller.ScreenTime) quality: 0,
                };

                for (final item in dataList) {
                  final category = item['screen_time'].toString().trim();
                  // print("Bed time value: $bedTime");
                  // print("Category value: $category");
                  // print("controller value: ${controller.sleepQuality}");
                  if (screenCounts.containsKey(category)) {
                    screenCounts[category] = screenCounts[category]! + 1;
                  }
                }

                final total = screenCounts.values.reduce((a, b) => a + b);
                for (int i = 0; i < controller.ScreenTime.length; i++) {
                  final category = controller.ScreenTime[i];
                  final count = screenCounts[category]!;
                  final double value = total > 0 ? (count / total) * 100 : 0;
                  // print("Sleep Counts: $sleepCounts");
                  // print("Total: $total");
                  sections.add(
                    PieChartSectionData(
                      color: controller.chartColors[i],
                      value: value,
                      title: value > 0 ? '${value.toStringAsFixed(1)}%' : '',
                      radius: 50,
                    ),
                  );
                }

                final avgText = controller.avgScreen.value;
                // print("avg text: ${avgText}");
                return Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Screen Time",
                          style: h4SemiBold,
                        ),
                        Text(
                          "Your spending time on gadget",
                          style: h6Regular,
                        ),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.touchedIndexScreen.value =
                                            -1;
                                        return;
                                      }
                                      controller.touchedIndexScreen.value =
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex;
                                    },
                                  ),
                                  sections: List.generate(
                                      controller.ScreenTime.length, (i) {
                                    final category = controller.ScreenTime[i];
                                    final count = screenCounts[category]!;
                                    final value =
                                        total > 0 ? (count / total) * 100 : 0;
                                    final isTouched =
                                        controller.touchedIndexScreen.value ==
                                            i;

                                    return PieChartSectionData(
                                      color: controller.chartColors[i],
                                      value: value.toDouble(),
                                      title: isTouched
                                          ? '${value.toStringAsFixed(1)}%'
                                          : '',
                                      radius: isTouched ? 55 : 50,
                                      titleStyle: h6SemiBold,
                                    );
                                  }),
                                  centerSpaceRadius: 50,
                                  sectionsSpace: 2,
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(avgText.toString(), style: h5SemiBold),
                                    Text("average",
                                        style: h6Regular.copyWith(
                                            color: greyColor)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: List.generate(
                                controller.ScreenTime.length, (index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: controller.chartColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  sbx5,
                                  Text(controller.ScreenTime[index],
                                      style: h6Regular),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
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
