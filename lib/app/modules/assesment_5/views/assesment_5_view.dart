import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/buttons.dart';
import '../controllers/assesment_5_controller.dart';

class Assesment5View extends GetView<Assesment5Controller> {
  const Assesment5View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  '5 of 7',
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
              'Apakah kamu sedang atau pernah mengkonsumsi obat?',
              textAlign: TextAlign.center,
              style: h3Bold,
            ),
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/medicine.png',
              scale: 2,
            ),
            const SizedBox(
              height: 100,
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
                              : whiteColor, // Warna berdasarkan pilihan
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
            const Spacer(),
            MyButton(
                get: () {
                  if (controller.isSelected.value == -1) {
                    Get.snackbar(
                      'Error',
                      'Silahkan isi assesment',
                      colorText: whiteColor,
                      backgroundColor: error.withOpacity(0.6),
                    );
                  } else {
                    Get.toNamed(Routes.ASSESMENT_6);
                  }
                },
                color: primaryColor,
                text: 'Lanjutkan')
          ],
        ),
      ),
    );
  }
}
