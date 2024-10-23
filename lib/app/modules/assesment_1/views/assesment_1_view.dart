import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/form.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/date.dart';
import '../../../widgets/favorite_button.dart';
import '../../../widgets/gender_selector.dart';
import '../controllers/assesment_1_controller.dart';

// ignore: must_be_immutable
class Assesment1View extends GetView<Assesment1Controller> {
  Assesment1View({Key? key}) : super(key: key);
  String selectedGender = '';
  String selectedDateOfBirth = '';
  String selectedMBTI = '';
  List<String> favoriteTopics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Assesment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  '1 of 7',
                  style: assestmentPoint,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              form(),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Gender',
                style: textDescriptionSemiBold,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GenderSelector(
                        gender: Gender.male,
                        selectedGender: controller.selectedGender.value,
                        onSelect: (gender) {
                          controller.toggleGender(gender);
                        }),
                    GenderSelector(
                        gender: Gender.female,
                        selectedGender: controller.selectedGender.value,
                        onSelect: (gender) {
                          controller.toggleGender(gender);
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Tanggal Lahir',
                style: textDescriptionSemiBold,
              ),
              const SizedBox(
                height: 8,
              ),
              date(),
              const SizedBox(
                height: 16,
              ),
              Text(
                'MBTI',
                style: textDescriptionSemiBold,
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownSearch<String>(
                items: (filter, infiniteScrollProps) => [
                  'INFJ',
                  'INFP',
                  'INTJ',
                  'INTP',
                  'ISFJ',
                  'ISFP',
                  'ISTP',
                  'ISTJ',
                  'ENFJ',
                  'ENFP',
                  'ENTJ',
                  'ENTP',
                  'ESFJ',
                  'ESFP',
                  'ESTP',
                  'ESTJ'
                ],
                suffixProps: const DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                    iconClosed: Icon(Icons.keyboard_arrow_down),
                    iconOpened: Icon(Icons.keyboard_arrow_up),
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black26,
                          width: 2,
                        ),
                      ),
                      hintText: 'Pilih MBTI',
                      hintStyle: textFieldStyle),
                ),
                popupProps: PopupProps.menu(
                  itemBuilder: (context, item, isDisabled, isSelected) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        item,
                        style: textFieldStyle,
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  constraints: const BoxConstraints(maxHeight: 160),
                  menuProps: const MenuProps(
                    margin: EdgeInsets.only(top: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                onChanged: (mbti) {
                  controller.setMBTI(mbti ?? '');
                },
                selectedItem: controller.selectedMBTI.value,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Favorite Topic',
                style: textDescriptionSemiBold,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        FavoriteButton(
                          get: () {
                            controller.toggleTopis('Sport');
                          },
                          colorBorder: controller.isSportTap.value
                              ? whiteColor
                              : primaryColor,
                          colorBackground: controller.isSportTap.value
                              ? primaryColor
                              : whiteColor,
                          text: 'Sport',
                        ),
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Art');
                            },
                            colorBorder: controller.isArtTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isArtTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Art'),
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Politics');
                            },
                            colorBorder: controller.isPoliticsTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isPoliticsTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Politics'),
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Anxiety');
                            },
                            colorBorder: controller.isAnxietyTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isAnxietyTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Anxiety'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Tech');
                            },
                            colorBorder: controller.isTechTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isTechTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Tech'),
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Innovation');
                            },
                            colorBorder: controller.isInnovationTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isInnovationTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Innovation'),
                        FavoriteButton(
                            get: () {
                              controller.toggleTopis('Lainnya');
                            },
                            colorBorder: controller.isLainnyaTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground: controller.isLainnyaTap.value
                                ? primaryColor
                                : whiteColor,
                            text: 'Lainnya'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                  child: MyButton(
                      get: () {}, color: primaryColor, text: 'Lanjutkan'))
            ],
          ),
        ),
      ),
    );
  }
}
