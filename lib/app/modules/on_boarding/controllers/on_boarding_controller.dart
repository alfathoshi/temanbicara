// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/onboarding_model.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class OnBoardingController extends GetxController {
  final currentPage = (-1).obs;
  final currentImage = ''.obs;
  final pages = <OnboardingPage>[].obs;

  Future<void> loadPages() async {
    final loadedPages = await loadOnboardingPages();
    pages.assignAll(loadedPages);
  }

  Future<List<OnboardingPage>> loadOnboardingPages() async {
    final jsonString =
        await rootBundle.loadString('assets/data/on_boarding_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((e) {
      final title = (e['title'] as List).cast<String>();
      final description = (e['description'] as List).cast<String>();
      final image = e['image'] as String;

      return OnboardingPage(
        title: title,
        description: description,
        image: image,
      );
    }).toList();
  }

  bool get isLastPage => currentPage.value == pages.length - 1;

  void nextPage() {
    if (pages.isEmpty) return;

    if (currentPage.value == -1) {
      currentPage.value = 0;
      final newImage = pages[0].image;
      setCurrentImage(newImage);
      animateDescription();
      animateImage();
    } else if (!isLastPage) {
      currentPage.value++;
      final newImage = pages[currentPage.value].image;
      setCurrentImage(newImage);
      animateDescription();
      animateImage();
    } else {
      Get.offAllNamed(Routes.SIGNUP);
    }
  }

  void skipToEnd() async {
    if (pages.isEmpty) return;

    currentPage.value = pages.length - 1;
    final newImage = pages[currentPage.value].image;
    await setCurrentImage(newImage);
    animateDescription();
    animateImage();
  }

  @override
  void onInit() {
    super.onInit();
    loadPages();
  }

  Future<void> setCurrentImage(String newImage) async {
    currentImage.value = '';
    await Future.delayed(const Duration(milliseconds: 30));
    currentImage.value = newImage;
  }

  // Desc
  final descOffsets = List.generate(3, (_) => 100.0.obs);
  final descOpacities = List.generate(3, (_) => 0.0.obs);
  final prevDesc = <String>[].obs;
  final isTextVisible = List.generate(3, (_) => true.obs);

  void animateDescription() async {
    final desc = pages[currentPage.value].description;

    for (int i = 0; i < 3; i++) {
      isTextVisible[i].value = false;
    }

    await Future.delayed(const Duration(milliseconds: 400));
    prevDesc.assignAll(desc);

    for (int i = 0; i < 3; i++) {
      isTextVisible[i].value = true;
      await Future.delayed(const Duration(milliseconds: 150));
    }
  }

  // image
  final imageScale = 0.8.obs;
  final imageOpacity = 0.0.obs;

  void animateImage() async {
    imageScale.value = 0.8;
    imageOpacity.value = 0.0;
    await Future.delayed(const Duration(milliseconds: 200));
    imageScale.value = 1.0;
    imageOpacity.value = 1.0;
  }
}
