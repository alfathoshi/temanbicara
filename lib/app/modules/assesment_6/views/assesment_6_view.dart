import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/buttons.dart';
import '../controllers/assesment_6_controller.dart';

class Assesment6View extends GetView<Assesment6Controller> {
  const Assesment6View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Assesment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  '6 of 7',
                  style: assestmentPoint,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height -
                  (AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Apakah kamu punya gejala kesehatan mental setelah konsultasi?',
                    textAlign: TextAlign.center,
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/gejala.png',
                    scale: 2,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                      cursorColor: black,
                      decoration: InputDecoration(
                        hintText: 'Tuliskan gejalamu disini...',
                        hintStyle: h5Regular.copyWith(color: grey2Color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greyColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      )),
                  Spacer(),
                  MyButton(
                      get: () {
                        Get.toNamed(Routes.ASSESMENT_7);
                      },
                      color: primaryColor,
                      text: 'Lanjutkan')
                ],
              ),
            ),
            sby8,
            Center(
              child: Text(
                'Kalau gak ada, skip aja!',
                style: warningGoals,
              ),
            ),
            const Spacer(),
            MyButton(
                get: () {
                  Get.toNamed(Routes.ASSESMENT_7);
                },
                color: primaryColor,
                text: 'Lanjutkan')
          ],
        ),
      ),
    );
  }
}
