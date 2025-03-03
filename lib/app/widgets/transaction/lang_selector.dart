import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temanbicara/app/modules/change_language/controllers/change_language_controller.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class LangSelector extends StatelessWidget {
  final Lang lang;
  final Lang selectedLang;
  final Function(Lang) onSelect;

  const LangSelector(
      {super.key,
      required this.lang,
      required this.selectedLang,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedLang == lang;

    return Container(
      // onTap: () => onSelect(lang),
      child: Column(
        children: [
          RadioMenuButton(
              value: 'English',
              groupValue: selectedLang,
              onChanged: (selectedValue) {
                Obx() => onSelect(lang);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/enIcon.png',
                    scale: 4,
                  ),
                  sby12,
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
                  sby12,
                  Text(
                    'Bahasa Indonesia',
                    style: h4Medium,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
