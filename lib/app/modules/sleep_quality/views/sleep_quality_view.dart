import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/sleep_quality_controller.dart';

class SleepQualityView extends GetView<SleepQualityController> {
  const SleepQualityView({super.key});
  @override
  Widget build(BuildContext context) {
    SlidingUpPanelController slidingUpController = SlidingUpPanelController();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Sleep Quality',
              style: h2Bold,
            ),
            leading: const Icon(Icons.arrow_back),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 147,
                    width: 153,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox.square(
                          dimension: 120,
                          child: CircularProgressIndicator(
                            value: 30,
                            color: Color(0xFFF9C200),
                            strokeWidth: 10,
                          ),
                        ),
                        Text(
                          "6h Average",
                          style: h4Bold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Good",
                    style: h1Bold.copyWith(color: const Color(0xFFFEBE58)),
                  ),
                  Image.asset(
                    "/images/happy_bg.png",
                  ),
                ],
              ),
            ),
          ),
        ),
        SlidingUpPanelWidget(
          upperBound: 1.1,
          controlHeight: 450,
          panelController: slidingUpController,
          anchor: 0.7,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sleep Statistics",
                    style: h3Bold,
                  ),
                  Text(
                    "lebih baik dari 5 hari yang lalu. Perbanyak istirahat! Kamu perlu itu!",
                    style: h4Regular,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Sleep History",
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  for (int i = 0; i < 5; i++) const SleepHistoryItem(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SleepHistoryItem extends StatelessWidget {
  const SleepHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF9AD567).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFBDCF99),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBDCF99),
                    spreadRadius: 1,
                    blurRadius: 0.5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Kamu tidur selama 7.5 jam",
              style: h4Regular,
            ),
          ],
        ),
      ),
    );
  }
}
