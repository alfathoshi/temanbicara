import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/change_language_controller.dart';

// ignore: must_be_immutable
class ChangeLanguageView extends GetView<ChangeLanguageController> {
  ChangeLanguageView({super.key});
  List<Map<dynamic, String>> dataBahasa = [
    {'Icon': 'enIcon', 'bahasa': 'English'},
    {'Icon': 'inIcon', 'bahasa': 'Bahasa Indonesia'},
  ];
  String selectedLang = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Change Language',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 350,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          radioTheme: RadioThemeData(
                            fillColor: WidgetStateProperty.resolveWith(
                              (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.green;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        child: RadioMenuButton<Lang>(
                          value: Lang.english,
                          groupValue: controller.selectedLanguage.value,
                          onChanged: (selectedValue) {
                            controller.toggleLanguage(selectedValue as Lang);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/enIcon.png',
                                scale: 4,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'English',
                                style: h4Medium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          radioTheme: RadioThemeData(
                            fillColor: WidgetStateProperty.resolveWith(
                              (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.green;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        child: RadioMenuButton(
                          value: Lang.bahasa,
                          groupValue: controller.selectedLanguage.value,
                          onChanged: (selectedValue) {
                            controller.toggleLanguage(selectedValue!);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/inIcon.png',
                                scale: 4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Bahasa Indonesia',
                                style: h4Medium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
