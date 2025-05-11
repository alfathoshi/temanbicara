import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class OnBoardingController extends GetxController {
  final currentPage = 0.obs;
  final currentImage = ''.obs;

  final pages = [
    {
      "title": ["Talk Freely", "No Judgement"],
      "description": [
        "Feeling down? Need someone to talk to?",
        "Our chatbot is always ready to listen",
        "no judgment, just support."
      ],
      "image": "assets/images/boarding2.png",
    },
    {
      "title": ["Express", "How You Feel"],
      "description": [
        "Write down your mood and thoughts daily.",
        "Clear your mind and get to know yourself",
        "better through journaling."
      ],
      "image": "assets/images/boarding3.png",
    },
    {
      "title": ["Track", "Your Mental Health"],
      "description": [
        "Visualize your emotional patterns with graphs ",
        "and daily logs. Understand yourself and take steps",
        "toward healing."
      ],
      "image": "assets/images/boarding4.png",
    },
    {
      "title": ["Talk", "to a Professional"],
      "description": [
        "Need professional guidance?",
        "Book a session with trusted psychologists",
        "secure, easy, and personalized."
      ],
      "image": "assets/images/boarding5.png",
    },
    {
      "title": ["Learn", "and Grow"],
      "description": [
        "Access articles on mental health,",
        "self-care, overthinking, and more. ",
        "Read what you need, when you need it."
      ],
      "image": "assets/images/boarding6.png",
    },
    {
      "title": ["Become the ", "Best Version of You"],
      "description": [
        "Start your journey now.",
        "Teman Bicara is here for you.",
        "Let’s begin your journey toward a healthier you.",
      ],
      "image": "assets/images/boarding7.png",
    },
  ];

  bool get isLastPage => currentPage.value == pages.length - 1;

  void setCurrentImage(String newImage) async {
    currentImage.value = '';
    await Future.delayed(Duration(milliseconds: 30));
    currentImage.value = newImage;
  }

  void nextPage() {
    if (!isLastPage) {
      currentPage.value++;
      final newImage = pages[currentPage.value]["image"] as String;
      setCurrentImage(newImage);
      animateDescription();
      animateImage();
    } else {
      Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {"indexPage": 0});
    }
  }

  void skipToEnd() {
    currentPage.value = pages.length - 1;
    animateDescription();
    animateImage();
  }

  @override
  void onInit() {
    super.onInit();
    animateDescription();
    animateImage();
  }

  // Desc
  final descOffsets = List.generate(3, (_) => 100.0.obs);
  final descOpacities = List.generate(3, (_) => 0.0.obs);
  final prevDesc = <String>[].obs;
  final isTextVisible = List.generate(3, (_) => true.obs);

  void animateDescription() async {
    final desc = (pages[currentPage.value]["description"] as List)
        .map((e) => e.toString())
        .toList();

    for (int i = 0; i < 3; i++) {
      isTextVisible[i].value = false;
    }

    await Future.delayed(Duration(milliseconds: 400));
    prevDesc.assignAll(desc);

    for (int i = 0; i < 3; i++) {
      isTextVisible[i].value = true;
      await Future.delayed(Duration(milliseconds: 150));
    }
  }

  //image
  final imageScale = 0.8.obs;
  final imageOpacity = 0.0.obs;

  void animateImage() async {
    imageScale.value = 0.8;
    imageOpacity.value = 0.0;
    await Future.delayed(Duration(milliseconds: 200));
    imageScale.value = 1.0;
    imageOpacity.value = 1.0;
  }
}
