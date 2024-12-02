import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/home/views/home_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/tracking_4_controller.dart';

class Tracking4View extends GetView<Tracking4Controller> {
  const Tracking4View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ));
        },
        child: SafeArea(
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
