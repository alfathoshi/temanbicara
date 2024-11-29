import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/themes/colors.dart';
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
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            centerTitle: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Gimana dengan kualitas tidurmu hari ini?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
          ),
          SliverList.builder(
            itemCount: dataKualitasTidur.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.toggleImage(index);
                },
                child: Obx(
                  () => KualitasTidur(
                    kualitas: dataKualitasTidur[index]['kualitas'],
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
                MyButton(get: () {}, color: primaryColor, text: 'Lanjutkan'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
