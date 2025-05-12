import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/tracking_model.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import '../controllers/tracking_2_controller.dart';

class Tracking2View extends GetView<Tracking2Controller> {
  Tracking2View({super.key});

  @override
  final Tracking2Controller controller = Get.put(Tracking2Controller());

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
                      'Bagaimana mood-mu hari ini?',
                      style: h3Bold,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          if (controller.selectedNumber.value == 'Depresi')
                            Image.asset('assets/images/emosi1.png', scale: 4),
                          if (controller.selectedNumber.value == 'Sedih')
                            Image.asset('assets/images/emosi2.png', scale: 4),
                          if (controller.selectedNumber.value == 'Netral')
                            Image.asset('assets/images/emosi3.png', scale: 4),
                          if (controller.selectedNumber.value == 'Senang')
                            Image.asset('assets/images/emosi4.png', scale: 4),
                          if (controller.selectedNumber.value == 'Bahagia')
                            Image.asset('assets/images/emosi5.png', scale: 4),
                          Obx(() => controller.explanationText()),
                          Container(
                            height: 75,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(5, (index) {
                                  int moodIndex = index + 1;
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectNumber(moodIndex);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.158,
                                      decoration: ShapeDecoration(
                                        color:
                                            controller.selectedNumber.value ==
                                                    controller
                                                        .emotions[moodIndex - 1]
                                                ? controller.colorNumber()
                                                : Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          moodIndex.toString(),
                                          textAlign: TextAlign.center,
                                          style: h2Bold.copyWith(
                                            color: controller
                                                        .selectedNumber.value ==
                                                    controller
                                                        .emotions[moodIndex - 1]
                                                ? whiteColor
                                                : black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                            Get.toNamed(Routes.TRACKING_3,
                                arguments: TrackingModel(
                                    "", controller.selectedNumber.value, 0));
                          },
                          color: primaryColor,
                          text: 'Lanjutkan'),
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
