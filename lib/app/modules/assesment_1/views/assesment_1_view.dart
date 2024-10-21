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

class Assesment1View extends GetView<Assesment1Controller> {
  Assesment1View({Key? key}) : super(key: key);
  final Assesment1Controller _assesment1controller =
      Get.put(Assesment1Controller());
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
            SizedBox(
              width: 16,
            ),
            Text(
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
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              form(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Gender',
                style: textDescriptionSemiBold,
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GenderSelector(
                        gender: Gender.male,
                        selectedGender:
                            _assesment1controller.selectedGender.value,
                        onSelect: (gender) {
                          _assesment1controller.toggleGender(gender);
                        }),
                    GenderSelector(
                        gender: Gender.female,
                        selectedGender:
                            _assesment1controller.selectedGender.value,
                        onSelect: (gender) {
                          _assesment1controller.toggleGender(gender);
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Tanggal Lahir',
                style: textDescriptionSemiBold,
              ),
              SizedBox(
                height: 8,
              ),
              date(),
              SizedBox(
                height: 16,
              ),
              Text(
                'MBTI',
                style: textDescriptionSemiBold,
              ),
              SizedBox(
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
                suffixProps: DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                    iconClosed: Icon(Icons.keyboard_arrow_down),
                    iconOpened: Icon(Icons.keyboard_arrow_up),
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
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
                  constraints: BoxConstraints(maxHeight: 160),
                  menuProps: MenuProps(
                    margin: EdgeInsets.only(top: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                onChanged: (mbti) {
                  _assesment1controller.setMBTI(mbti ?? '');
                },
                selectedItem: _assesment1controller.selectedMBTI.value,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Favorite Topic',
                style: textDescriptionSemiBold,
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        FavoriteButton(
                          get: () {
                            _assesment1controller.toggleTopis('Sport');
                          },
                          colorBorder: _assesment1controller.isSportTap.value
                              ? whiteColor
                              : primaryColor,
                          colorBackground:
                              _assesment1controller.isSportTap.value
                                  ? primaryColor
                                  : whiteColor,
                          text: 'Sport',
                        ),
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Art');
                            },
                            colorBorder: _assesment1controller.isArtTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground:
                                _assesment1controller.isArtTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Art'),
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Politics');
                            },
                            colorBorder:
                                _assesment1controller.isPoliticsTap.value
                                    ? whiteColor
                                    : primaryColor,
                            colorBackground:
                                _assesment1controller.isPoliticsTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Politics'),
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Anxiety');
                            },
                            colorBorder:
                                _assesment1controller.isAnxietyTap.value
                                    ? whiteColor
                                    : primaryColor,
                            colorBackground:
                                _assesment1controller.isAnxietyTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Anxiety'),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Tech');
                            },
                            colorBorder: _assesment1controller.isTechTap.value
                                ? whiteColor
                                : primaryColor,
                            colorBackground:
                                _assesment1controller.isTechTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Tech'),
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Innovation');
                            },
                            colorBorder:
                                _assesment1controller.isInnovationTap.value
                                    ? whiteColor
                                    : primaryColor,
                            colorBackground:
                                _assesment1controller.isInnovationTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Innovation'),
                        FavoriteButton(
                            get: () {
                              _assesment1controller.toggleTopis('Lainnya');
                            },
                            colorBorder:
                                _assesment1controller.isLainnyaTap.value
                                    ? whiteColor
                                    : primaryColor,
                            colorBackground:
                                _assesment1controller.isLainnyaTap.value
                                    ? primaryColor
                                    : whiteColor,
                            text: 'Lainnya'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
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
