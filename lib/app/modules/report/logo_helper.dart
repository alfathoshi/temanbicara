import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogoHelper {
  static Map<String, String> sleepQuality = {
    "Insomnia": "assets/images/emosi1.png",
    "Kurang": "assets/images/emosi2.png",
    "Cukup": "assets/images/emosi3.png",
    "Baik": "assets/images/emosi4.png",
    "Nyenyak": "assets/images/emosi5.png",
  };

  static Map<String, String> moodLevel = {
    "Depresi": "assets/images/emosi1.png",
    "Sedih": "assets/images/emosi2.png",
    "Netral": "assets/images/emosi3.png",
    "Senang": "assets/images/emosi4.png",
    "Bahagia": "assets/images/emosi5.png",
  };

  static Map<int, String> stressLevel = {
    5: "assets/images/emosi1.png",
    4: "assets/images/emosi2.png",
    3: "assets/images/emosi3.png",
    2: "assets/images/emosi4.png",
    1: "assets/images/emosi5.png",
  };

  static Color colorByLevel(String level) {
    if (level == "1" || level == "Insomnia" || level == "Depresi") {
      return Colors.purple;
    }

    if (level == "2" || level == "Kurang" || level == "Sedih") {
      return Colors.green;
    }

    if (level == "3" || level == "Netral" || level == "Cukup") {
      return Colors.yellow;
    }

    if (level == "4" || level == "Senang" || level == "Baik") {
      return Colors.orange;
    }

    if (level == "5" || level == "Nyenyak" || level == "Bahagia") {
      return Colors.deepOrange;
    }

    return Colors.red;
  }
}
