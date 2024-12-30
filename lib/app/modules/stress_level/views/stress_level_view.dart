import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/report/logo_helper.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/stress_level_controller.dart';

class StressLevelView extends GetView<StressLevelController> {
  const StressLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    Random rng = Random();
    int stressLevel = Get.arguments[1].value;
    SlidingUpPanelController slidingUpController = SlidingUpPanelController();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Stress Level',
              style: h2Bold,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
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
                        Image.asset(LogoHelper.stressLevel[6 - stressLevel]!)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Level ${stressLevel.toString()}",
                    style: h1Bold.copyWith(
                      color: const Color(0xFF7A914B),
                    ),
                  ),
                  Image.asset(
                    "assets/images/stresslv3.png",
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
              child: ListView(
                // physics: const NeverScrollableScrollPhysics(),
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
                    "Stress Description",
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    stressLevel <= 3
                        ? "Kamu hebat banget! Jangan biarkan hal kecil merusak semangatmu hari ini."
                        : "Kadang, yang kamu butuhkan hanya istirahat sejenak untuk melihat segalanya lebih jelas. Kamu pasti bisa mengatasinya",
                    style: h4Regular,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Bukan apa yang terjadi padamu yang membuatmu stres, tetapi cara kamu memandangnya.",
                    style: h4Regular.copyWith(fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "-Epictetus",
                    style: h4Bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StressItem(
                        title1: "Level",
                        title2: "Medium",
                        widget: Text(
                          "$stressLevel/5",
                          style: h1Bold.copyWith(
                            color: const Color(0xFF7A914B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Stressor ",
                    style: h3Bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StressIndicator(
                    title: "Loneliness",
                    value: rng.nextInt(100) / 100,
                    indicatorColor: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StressIndicator(
                    title: "Work",
                    value: rng.nextInt(100) / 100,
                    indicatorColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StressIndicator(
                    title: "Family",
                    value: rng.nextInt(100) / 100,
                    indicatorColor: Colors.green,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StressIndicator(
                    title: "Work",
                    value: rng.nextInt(100) / 100,
                    indicatorColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StressIndicator extends StatelessWidget {
  final double value;
  final String title;
  final Color indicatorColor;

  const StressIndicator({
    super.key,
    required this.value,
    required this.title,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: h4Medium,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 213, 213, 213),
                  blurRadius: 10,
                  spreadRadius: 0.01,
                  offset: Offset(0, 1))
            ],
          ),
          child: LinearProgressIndicator(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            minHeight: 35,
            value: value,
            color: indicatorColor,
          ),
        ),
      ],
    );
  }
}

class StressItem extends StatelessWidget {
  final String title1;
  final String title2;
  final Widget widget;
  const StressItem(
      {super.key,
      required this.widget,
      required this.title1,
      required this.title2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width - 71) / 2,
      height: 170,
      decoration: const BoxDecoration(
          color: Color(0xFFE3E9D9),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 0.1,
                offset: Offset(2, 3))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: h5Medium,
            ),
            Text(
              title2,
              style: h4Bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}
