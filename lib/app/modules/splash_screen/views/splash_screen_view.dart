import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTestEnv = Platform.environment.containsKey('FLUTTER_TEST');
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isTestEnv
                ? const FlutterLogo(size: 100)
                : Image.asset(
                    'assets/images/logo.png',
                    scale: 2,
                  ),
            const SizedBox(height: 12),
            Text('Teman Bicara', style: textLogo),
          ],
        ),
      ),
    );
  }
}
