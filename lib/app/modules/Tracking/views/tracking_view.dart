import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Tracking.dart';
import 'package:temanbicara/app/modules/Tracking/controllers/tracking_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/kualitas_tidur.dart';
import 'package:temanbicara/app/widgets/sleep_quality.dart';

// import '../controllers/tracking_controller.dart';
import '../../assesment_3/controllers/assesment_3_controller.dart';

class TrackingView extends GetView<TrackingController> {
  TrackingView({super.key});
  List<Map<String, dynamic>> dataKualitasTidur = [
    {'kualitas': 'Nyenyak', 'waktu': '8 - 9 jam', 'emosi': 'emosi5'},
    {'kualitas': 'Baik', 'waktu': '7 - 8 jam', 'emosi': 'emosi4'},
    {'kualitas': 'Cukup', 'waktu': '6 jam', 'emosi': 'emosi3'},
    {'kualitas': 'Kurang', 'waktu': '4 - 5 jam', 'emosi': 'emosi2'},
    {'kualitas': 'Insomnia', 'waktu': '< 4 jam', 'emosi': 'emosi1'},
  ];

  // final TrackingController controller = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    final Assesment3Controller controller = Get.find();
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
            'Tracking',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height -
                      (AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.bottom),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Apa yang ingin kamu capai?',
                          textAlign: TextAlign.center,
                          style: h3Bold,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const SleepQuality(
                          desc: 'Nyenyak',
                          time: '8 - 9 Jam',
                          index: 4,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SleepQuality(
                          desc: 'Baik',
                          time: '7 - 8 Jam',
                          index: 3,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SleepQuality(
                          desc: 'Cukup',
                          time: '6 - 7 Jam',
                          index: 2,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SleepQuality(
                          desc: 'Kurang',
                          time: '5 - 6 Jam',
                          index: 1,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SleepQuality(
                          desc: 'Insomnia',
                          time: '< 4 Jam',
                          index: 0,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text('Silahkan pilih salah satu!', style: warningGoals),
                        const SizedBox(
                          height: 40,
                        ),
                        MyButton(
                            get: () {
                              if (controller.tappedIndex.value == -1) {
                                Get.snackbar(
                                  'Error',
                                  'Silahkan isi Tracking',
                                  colorText: whiteColor,
                                  backgroundColor: error.withOpacity(0.6),
                                );
                              } else {
                                Get.toNamed(Routes.ASSESMENT_4);
                              }
                            },
                            color: primaryColor,
                            text: 'Lanjutkan')
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
