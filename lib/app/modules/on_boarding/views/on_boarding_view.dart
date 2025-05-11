import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Obx(() {
            final index = controller.currentPage.value;

            if (index == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/boardingLogo.png",
                  ),
                  sby32,
                  Text("Welcome to", style: h3Bold),
                  Text(
                    "Teman Bicara",
                    style: h2Bold.copyWith(color: primaryColor),
                  ),
                  sby36,
                  Center(
                    child: SizedBox(
                      height: 300,
                      child: Image.asset(
                        "assets/images/boarding1.png",
                        height: 160,
                      ),
                    ),
                  ),
                  sby36,
                  MyButtonCustom(
                    text: "Next",
                    get: () {
                      controller.nextPage();
                      controller.animateImage();
                    },
                    height: 64,
                    width: double.infinity,
                    style: h3Bold.copyWith(color: whiteColor),
                    backColor: primaryColor,
                    foreColor: whiteColor,
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account ? ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF60ABEE),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }

            final page = controller.pages[controller.currentPage.value];
            final title =
                (page["title"] as List).map((e) => e.toString()).toList();
            final desc =
                (page["description"] as List).map((e) => e.toString()).toList();
            final String image = page["image"] as String;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE + BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title[0], style: h3Bold),
                        Text(title[1], style: h3Bold),
                      ],
                    ),
                    Obx(() {
                      if (controller.currentPage.value ==
                          controller.pages.length - 1) {
                        return const SizedBox(width: 10);
                      }

                      return MyButtonOutlinedCustom(
                        get: controller.skipToEnd,
                        foreColor: primaryColor,
                        backColor: whiteColor,
                        text: "lewati",
                        height: 45,
                        width: 100,
                        style: h5SemiBold.copyWith(color: primaryColor),
                      );
                    }),
                  ],
                ),
                sby24,
                // DESCRIPTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(3, (i) {
                    return Obx(() {
                      final visible = controller.isTextVisible[i].value;
                      final text = controller.prevDesc.length > i
                          ? controller.prevDesc[i]
                          : "";

                      return AnimatedOpacity(
                        opacity: visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          transform: Matrix4.translationValues(
                              visible ? 0 : -30, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              text,
                              style: h6SemiBold,
                            ),
                          ),
                        ),
                      );
                    });
                  }),
                ),
                sby48,
                // IMAGE
                Center(
                  child: SizedBox(
                    height: 300,
                    child: Obx(() {
                      final img = controller.currentImage.value;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                        child: img.isEmpty
                            ? const SizedBox.shrink()
                            : Image.asset(
                                img,
                                key: ValueKey(img),
                              ),
                      );
                    }),
                  ),
                ),
                sby48,
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: controller.currentPage.value - 1,
                    count: controller.pages.length - 1,
                    effect: ExpandingDotsEffect(
                      dotColor: grey2Color,
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
                sby24,
                MyButtonCustom(
                  get: controller.nextPage,
                  text: controller.isLastPage ? "Let's Get Started" : "Next",
                  foreColor: whiteColor,
                  backColor: primaryColor,
                  height: 64,
                  width: double.infinity,
                  style: h3Bold.copyWith(color: whiteColor),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
