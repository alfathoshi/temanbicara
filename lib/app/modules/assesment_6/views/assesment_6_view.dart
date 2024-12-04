import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      backgroundColor: whiteColor,
      appBar: AppBar(
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
              decoration: InputDecoration(
                labelText: 'Tuliskan Gejalamu disini...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: Colors.black26,
                    width: 2,
                  ),
                ),
              ),
            ),
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
    );
  }
}
