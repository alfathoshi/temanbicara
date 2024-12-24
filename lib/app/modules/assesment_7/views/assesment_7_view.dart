import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/assesment_7_controller.dart';

class Assesment7View extends GetView<Assesment7Controller> {
  const Assesment7View({Key? key}) : super(key: key);
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
                    '7 of 7',
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
            children: [
              Text(
                'Berapa nilai yang kamu berikan untuk tingkat stress yang ada?',
                textAlign: TextAlign.center,
                style: h3Bold,
              ),
              SizedBox(
                height: 50,
              ),
              Obx(
                () => Column(
                  children: [
                    Text(
                      '${controller.selectedNumber.value}',
                      style: h1Bold.copyWith(
                        fontSize: 100,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: const Color(0xFF7D944D)),
                      ),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                controller.selectNumber(i);
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: ShapeDecoration(
                                  color: controller.selectedNumber.value == i
                                      ? Color(0xFF7D944D)
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    i.toString(),
                                    textAlign: TextAlign.center,
                                    style: h2Bold.copyWith(
                                        color:
                                            controller.selectedNumber.value == i
                                                ? whiteColor
                                                : black),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '1 untuk tingkat stress rendah',
                      style: h7SemiBold.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              MyButton(
                  get: () {
                    controller.saveAssesment();
                  },
                  color: primaryColor,
                  text: 'Lanjutkan')
            ],
          ),
        ));
  }
}
