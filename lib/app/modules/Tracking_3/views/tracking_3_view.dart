import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../controllers/tracking_3_controller.dart';

class Tracking3View extends GetView<Tracking3Controller> {
  const Tracking3View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Berapa nilai yang kamu berikan untuk tingkat stress yang ada?',
                    style: h3Bold,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Text(
                          '${controller.selectedNumber.value}',
                          style: h1Bold.copyWith(
                            fontSize: 150,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
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
                              children: [
                                for (int i = 0; i <= 5; i++)
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
                                                ? primaryColor
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
                        Obx(() => controller.explanationText()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      get: () {
                        Get.toNamed(Routes.TRACKING_4);
                      },
                      color: primaryColor,
                      text: 'Selesai'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
