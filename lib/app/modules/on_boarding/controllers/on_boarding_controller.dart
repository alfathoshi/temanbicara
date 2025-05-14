import 'package:get/get.dart';
import 'package:temanbicara/app/data/on_boarding_data.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class OnBoardingController extends GetxController {
  final currentPage = 0.obs;
  final currentImage = ''.obs;

  final pages = onboardingPages;

  bool get isLastPage => currentPage.value == pages.length - 1;

  void nextPage() {
    if (!isLastPage) {
      currentPage.value++;
      final newImage = pages[currentPage.value].image;
      setCurrentImage(newImage);
      animateDescription();
      animateImage();
    } else {
      //Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {"indexPage": 0});
      Get.offAllNamed(Routes.SIGNUP);
    }
  }

  void skipToEnd() async {
    currentPage.value = pages.length - 1;

    final newImage = pages[currentPage.value].image;
    await setCurrentImage(newImage);

    animateDescription();
    animateImage();
  }

  @override
  void onInit() {
    super.onInit();
    animateDescription();
    animateImage();
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
    final desc = (pages[currentPage.value].description as List)
        .map((e) => e.toString())
        .toList();

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

  //image
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
