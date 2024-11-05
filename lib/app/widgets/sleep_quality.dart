import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/assesment_3/controllers/assesment_3_controller.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class SleepQuality extends StatelessWidget {
  const SleepQuality(
      {super.key, required this.index, required this.desc, required this.time});
  final String desc;
  final String time;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Assesment3Controller controller = Get.find();
    return GestureDetector(
      onTap: () {
        controller.toggleTap(index);
      },
      child: Obx(
        () => Container(
          height: 62,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: primaryColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
            color: controller.tappedIndex.value == index
                ? primaryColor
                : whiteColor,
          ),
          padding: const EdgeInsets.only(left: 24, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    desc,
                    style: controller.tappedIndex.value == index
                        ? sleepQualityTitleTap
                        : sleepQualityTitle,
                  ),
                  Text(
                    time,
                    style: controller.tappedIndex.value == index
                        ? sleepQualityTimeTap
                        : sleepQualityTime,
                  ),
                ],
              ),
              Image.asset(
                'assets/images/emosi${index + 1}.png',
                scale: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
