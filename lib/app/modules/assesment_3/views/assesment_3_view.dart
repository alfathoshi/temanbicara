import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/widgets/sleep_quality.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/buttons.dart';
import '../controllers/assesment_3_controller.dart';

class Assesment3View extends GetView<Assesment3Controller> {
  const Assesment3View({Key? key}) : super(key: key);
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
                    '3 of 7',
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
                height: 32,
              ),
              MyButton(get: () {}, color: primaryColor, text: 'Lanjutkan')
            ],
          ),
        ));
  }
}
