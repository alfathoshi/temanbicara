import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/new_tracking_controller.dart';

class NewTrackingView extends GetView<NewTrackingController> {
  const NewTrackingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
            color: border,
          ),
        ),
        title: Text(
          'Tracking',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
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
                                controller.toggleEmotion(index);
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ColorFiltered(
                                      colorFilter:
                                          controller.getColorEmotion(index),
                                      child: Text(
                                          '${controller.emotions[index]}',
                                          style: TrackingText.copyWith(
                                            color: controller.selectedEmotion
                                                        .value ==
                                                    controller.emotions[index]
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
              SizedBox(
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
                              onChanged: (value) {
                                controller.sliderValue.value = value;
                              },
                              activeColor: primaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              SizedBox(
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
                                controller.toggleSleepQuliaty(index);
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ColorFiltered(
                                      colorFilter:
                                          controller.getColorSleep(index),
                                      child: Text(
                                          '${controller.sleepQuality[index]}',
                                          style: TrackingText.copyWith(
                                            color: controller.selectedEmotion
                                                        .value ==
                                                    controller.emotions[index]
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
              SizedBox(
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
                                controller.toggleScreenTime(index);
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('${controller.ScreenTime[index]}',
                                        style: TrackingText.copyWith(
                                          color: controller
                                                      .selectedEmotion.value ==
                                                  controller.emotions[index]
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
              SizedBox(
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
                                controller.toggleActivity(index);
                              },
                              child: Obx(
                                () => Column(
                                  children: [
                                    ColorFiltered(
                                      colorFilter:
                                          controller.getColorActivity(index),
                                      child: Image.asset(
                                        'assets/images/step${index + 1}.png',
                                        scale: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('${controller.Activity[index]}',
                                        style: TrackingText.copyWith(
                                          color: controller
                                                      .selectedEmotion.value ==
                                                  controller.emotions[index]
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
              SizedBox(
                height: 16,
              ),
              MyButton(
                  get: () {
                    Get.offAllNamed(Routes.NAVIGATION_BAR);
                  },
                  color: primaryColor,
                  text: "Record")
            ],
          ),
        ),
      ),
    );
  }
}
