import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/assesment_2/controllers/assesment_2_controller.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class GoalsOptions extends StatelessWidget {
  const GoalsOptions({super.key, required this.option, required this.index});
  final String option;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Assesment2Controller controller = Get.find();
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
            color: whiteColor
          ),
          padding: const EdgeInsets.only(left: 24, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option,
                style: trackingButton,
              ),
              ClipOval(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                    color: controller.tappedIndex.value == index
                        ? primaryColor
                        : whiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
