import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/change_language_controller.dart';

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
        title: Text(
          'Change Language',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Center(
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
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioMenuButton(
                        value: 'English',
                        groupValue: selectedLang,
                        onChanged: (selectedValue) {
                          Obx() => selectedLang == selectedValue!;
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/enIcon.png',
                              scale: 4,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'English',
                              style: h4Medium,
                            ),
                          ],
                        )),
                    RadioMenuButton(
                        value: 'Indonesia',
                        groupValue: selectedLang,
                        onChanged: (selectedValue) {
                          Obx() => selectedLang == selectedValue!;
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/inIcon.png',
                              scale: 4,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Bahasa Indonesia',
                              style: h4Medium,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
