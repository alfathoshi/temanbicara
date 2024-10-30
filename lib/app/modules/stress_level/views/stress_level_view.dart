import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/stress_level_controller.dart';

class StressLevelView extends GetView<StressLevelController> {
  const StressLevelView({super.key});
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    "3",
                    style: h1Bold.copyWith(
                      fontSize: 80,
                      color: const Color(0xFF7A914B),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Good",
                    style: h1Bold.copyWith(color: const Color(0xFF7A914B)),
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
                physics: const NeverScrollableScrollPhysics(),
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
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StressItem(
                        title1: "Stressor",
                        title2: "Loneliness",
                        widget: Image.asset("assets/images/lonely.png"),
                      ),
                      StressItem(
                        title1: "Level",
                        title2: "Medium",
                        widget: Text(
                          "3/5",
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
                  const StressIndicator(
                    title: "Loneliness",
                    value: 0.5,
                    indicatorColor: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const StressIndicator(
                    title: "Work",
                    value: 0.4,
                    indicatorColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const StressIndicator(
                    title: "Family",
                    value: 0.1,
                    indicatorColor: Colors.green,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const StressIndicator(
                    title: "Work",
                    value: 0.9,
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
        LinearProgressIndicator(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          minHeight: 35,
          value: value,
          color: indicatorColor,
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
      ),
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
