import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Tracking.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../controllers/tracking_3_controller.dart';

class Tracking3View extends GetView<Tracking3Controller> {
  Tracking3View({super.key});

  final Tracking3Controller controller = Get.put(Tracking3Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 85,
            backgroundColor: whiteColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12),
            ),
            title: Text(
              'Tracking',
              style: h3Bold,
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
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
                          const SizedBox(
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
                                  for (int i = 1; i <= 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectNumber(i);
                                      },
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.183,
                                        decoration: ShapeDecoration(
                                          color:
                                              controller.selectedNumber.value ==
                                                      i
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
                          sby12,
                          Obx(() => controller.explanationText()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MyButton(
                          get: () {
                            if (controller.selectedNumber.value == 0) {
                              Get.snackbar(
                                'Error',
                                'Silakan isi Tracking',
                                colorText: whiteColor,
                                backgroundColor: Colors.red.withOpacity(0.7),
                              );
                            } else {
                              Get.toNamed(Routes.TRACKING_4,
                                  arguments: TrackingModel(
                                      "", "", controller.selectedNumber.value));
                            }
                          },
                          color: primaryColor,
                          text: 'Selesai'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
