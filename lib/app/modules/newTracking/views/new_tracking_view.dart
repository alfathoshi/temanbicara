import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../themes/spaces.dart';
import '../controllers/new_tracking_controller.dart';

class NewTrackingView extends GetView<NewTrackingController> {
  const NewTrackingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: Text(
          "Tracking",
          style: h3Bold,
        ),
      ),
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: border,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mood Today',
                            style: h6SemiBold,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              5,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!controller.isLoading.value) {
                                      controller.toggleEmotion(index);
                                    }
                                  },
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        ColorFiltered(
                                          colorFilter:
                                              controller.getColorEmotion(index),
                                          child: Image.asset(
                                              'assets/images/emosi${index + 1}.png',
                                              scale: 10),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ColorFiltered(
                                          colorFilter:
                                              controller.getColorEmotion(index),
                                          child:
                                              Text(controller.emotions[index],
                                                  style: trackingText.copyWith(
                                                    color: controller
                                                                .selectedEmotion
                                                                .value ==
                                                            controller
                                                                .emotions[index]
                                                        ? Colors.black
                                                        : Colors.grey,
                                                  )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: border,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Strees Level',
                            style: h6SemiBold,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                Slider(
                                  value: controller.sliderValue.value,
                                  divisions: 4,
                                  min: 0,
                                  max: 4,
                                  onChanged: controller.isLoading.value
                                      ? null
                                      : (value) {
                                          controller.sliderValue.value = value;
                                        },
                                  activeColor: primaryColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    for (int i = 1; i <= 5; i++)
                                      Text(
                                        i.toString(),
                                        style: h6SemiBold,
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: border,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bed Time',
                            style: h6SemiBold,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              5,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!controller.isLoading.value) {
                                      controller.toggleSleepQuliaty(index);
                                    }
                                  },
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        ColorFiltered(
                                          colorFilter:
                                              controller.getColorSleep(index),
                                          child: Image.asset(
                                              'assets/images/sleep${index + 1}.png',
                                              scale: 2),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ColorFiltered(
                                          colorFilter:
                                              controller.getColorSleep(index),
                                          child: Text(
                                            controller.sleepQuality[index],
                                            style: trackingText.copyWith(
                                              color: controller.selectedSleep
                                                          .value ==
                                                      controller
                                                          .sleepQuality[index]
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: border,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Screen Time',
                            style: h6SemiBold,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              5,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!controller.isLoading.value) {
                                      controller.toggleScreenTime(index);
                                    }
                                  },
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        ColorFiltered(
                                          colorFilter:
                                              controller.getColorScreen(index),
                                          child: Image.asset(
                                            'assets/images/screen${index + 1}.png',
                                            scale: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(controller.screenTime[index],
                                            style: trackingText.copyWith(
                                              color: controller.selectedScreen
                                                          .value ==
                                                      controller
                                                          .screenTime[index]
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: border,
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activity',
                            style: h6SemiBold,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              5,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!controller.isLoading.value) {
                                      controller.toggleActivity(index);
                                    }
                                  },
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: controller
                                              .getColorActivity(index),
                                          child: Image.asset(
                                            'assets/images/step${index + 1}.png',
                                            scale: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(controller.activity[index],
                                            style: trackingText.copyWith(
                                              color: controller.selectedActivity
                                                          .value ==
                                                      controller.activity[index]
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sby16,
                  MyButton(
                    get: () async {
                      await controller.storeTracking();
                    },
                    color: primaryColor,
                    text: "Record",
                  ),
                  sby16,
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
