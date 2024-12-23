import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/goalsOptions.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../assesment_1/controllers/assesment_1_controller.dart';
import '../controllers/assesment_2_controller.dart';

class Assesment2View extends GetView<Assesment2Controller> {
   Assesment2View({Key? key}) : super(key: key);

  final box = GetStorage();

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
                    '2 of 7',
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
                'Apa yang ingin kamu capai?',
                textAlign: TextAlign.center,
                style: h3Bold,
              ),
              const SizedBox(
                height: 40,
              ),
              const Goalsoptions(
                option: 'Aku Ingin mengurangi stress',
                index: 0,
              ),
              const SizedBox(
                height: 32,
              ),
              const Goalsoptions(
                option: 'Aku Ingin punya seorang teman',
                index: 1,
              ),
              const SizedBox(
                height: 32,
              ),
              const Goalsoptions(
                option: 'Aku Ingin berinteraksi dengan AI',
                index: 2,
              ),
              const SizedBox(
                height: 32,
              ),
              const Goalsoptions(
                option: 'Aku Ingin bertemu orang baru',
                index: 3,
              ),
              const SizedBox(
                height: 32,
              ),
              const Goalsoptions(
                option: 'Hanya iseng mencoba',
                index: 4,
              ),
              const SizedBox(
                height: 32,
              ),
              Text('Silahkan pilih goalsmu', style: warningGoals),
              Spacer(),
              MyButton(
                  get: () {
                    Get.toNamed(Routes.ASSESMENT_3);
                  },
                  color: primaryColor,
                  text: 'Lanjutkan')
            ],
          ),
        ));
  }
}
