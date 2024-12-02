import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../controllers/tracking_2_controller.dart';

class Tracking2View extends GetView<Tracking2Controller> {
  Tracking2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 6,
                  ),
                ),
                Text(
                  'Tracking',
                  style: h3Bold,
                ),
              ],
            ),
            centerTitle: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Bagaimana mood-mu hari ini?',
                    style: h3Bold,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        if (controller.selectedNumber.value == 1)
                          Image.asset(
                            'assets/images/emosi1.png',
                            scale: 4,
                          ),
                        if (controller.selectedNumber.value == 2)
                          Image.asset(
                            'assets/images/emosi2.png',
                            scale: 4,
                          ),
                        if (controller.selectedNumber.value == 3)
                          Image.asset(
                            'assets/images/emosi3.png',
                            scale: 4,
                          ),
                        if (controller.selectedNumber.value == 4)
                          Image.asset(
                            'assets/images/emosi4.png',
                            scale: 4,
                          ),
                        if (controller.selectedNumber.value == 5)
                          Image.asset(
                            'assets/images/emosi5.png',
                            scale: 4,
                          ),
                        Obx(() => controller.explanationText()),
                        Container(
                          height: 75,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  GestureDetector(
                                    onTap: () {
                                      controller.selectNumber(i);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.158,
                                      decoration: ShapeDecoration(
                                        color:
                                            controller.selectedNumber.value == i
                                                ? controller.colorNum
                                                : Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          i.toString(),
                                          textAlign: TextAlign.center,
                                          style: h2Bold.copyWith(
                                              color: controller.selectedNumber
                                                          .value ==
                                                      i
                                                  ? whiteColor
                                                  : black),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      get: () {
                        Get.toNamed(Routes.TRACKING_3);
                      },
                      color: primaryColor,
                      text: 'Lanjutkan'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
