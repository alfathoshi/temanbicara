import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/home/views/home_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/tracking_4_controller.dart';

class Tracking4View extends GetView<Tracking4Controller> {
  Tracking4View({super.key});

  @override
  final Tracking4Controller controller = Get.put(Tracking4Controller());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.storedTracking();
        Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {'indexPage': 0});
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Image.asset(
                      'assets/icons/success.png',
                      scale: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Tracking Selesai',
                        style: h2SemiBold.copyWith(color: whiteColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Data rekaman kesehatan mentalmu hari ini telah berhasil disimpan',
                        style: h4Medium.copyWith(color: whiteColor),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Tap anywhere...',
                    style: h4Medium.copyWith(color: whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
