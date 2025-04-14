import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Tracking.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/kualitas_tidur.dart';

import '../controllers/tracking_controller.dart';

class TrackingView extends GetView<TrackingController> {
  TrackingView({super.key});
  List<Map<String, dynamic>> dataKualitasTidur = [
    {'kualitas': 'Nyenyak', 'waktu': '8 - 9 jam', 'emosi': 'emosi5'},
    {'kualitas': 'Baik', 'waktu': '7 - 8 jam', 'emosi': 'emosi4'},
    {'kualitas': 'Cukup', 'waktu': '6 jam', 'emosi': 'emosi3'},
    {'kualitas': 'Kurang', 'waktu': '4 - 5 jam', 'emosi': 'emosi2'},
    {'kualitas': 'Insomnia', 'waktu': '< 4 jam', 'emosi': 'emosi1'},
  ];

  final TrackingController controller = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
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
                'Tracking',
                style: h3Bold,
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Gimana dengan kualitas tidurmu hari ini?",
                  style: h3Bold,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ),
            SliverList.builder(
              itemCount: dataKualitasTidur.length,
              itemBuilder: (context, index) {
                final kualitas = dataKualitasTidur[index]['kualitas'];
                return GestureDetector(
                  onTap: () {
                    controller.toggleImage(index, kualitas);
                  },
                  child: Obx(
                    () => KualitasTidur(
                      kualitas: kualitas,
                      waktu: dataKualitasTidur[index]['waktu'],
                      Image: dataKualitasTidur[index]['emosi'],
                      textColor: controller.changeColor(index),
                      BackgroundColor: controller.changeBackgroundColor(index),
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Obx(() => controller.warningText()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MyButton(
                        get: () {
                          print(controller.selectedKualitasTidur.value!);
                          Get.toNamed(Routes.TRACKING_2,
                              arguments: TrackingModel(
                                  controller.selectedKualitasTidur.value!,
                                  "",
                                  0));
                        },
                        color: primaryColor,
                        text: 'Lanjutkan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
