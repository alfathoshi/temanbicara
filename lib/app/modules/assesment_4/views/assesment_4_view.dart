import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/assesment_4_controller.dart';

class Assesment4View extends GetView<Assesment4Controller> {
  const Assesment4View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  '4 of 7',
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
              'Pernah gak kamu konsultasi ke tenaga profesional sebelumnya?',
              textAlign: TextAlign.center,
              style: h3Bold,
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/consultImg.png',
              scale: 2,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectOption(0);
                  },
                  child: Obx(() => Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                          color: controller.isSelected.value == 0
                              ? primaryColor
                              : whiteColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            'Ya',
                            style: controller.isSelected.value == 0
                                ? ConsultOptionTap
                                : ConsultOption,
                          ),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectOption(1);
                  },
                  child: Obx(() => Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                          color: controller.isSelected.value == 1
                              ? primaryColor
                              : whiteColor, 
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            'Tidak',
                            style: controller.isSelected.value == 1
                                ? ConsultOptionTap
                                : ConsultOption,
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Spacer(),
            MyButton(get: () {
              Get.toNamed(Routes.ASSESMENT_5);
            }, color: primaryColor, text: 'Lanjutkan')
          ],
        ),
      ),
    );
  }
}
