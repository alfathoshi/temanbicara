import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/date.dart';
import '../../../widgets/favorite_button.dart';
import '../../../widgets/gender_selector.dart';
import '../controllers/assesment_1_controller.dart';

class Assesment1View extends GetView<Assesment1Controller> {
  Assesment1View({super.key});

  final DatePickerController dateController = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
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
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: textDescriptionSemiBold,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controller.nameC,
              cursorColor: black,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama Lengkap',
                hintStyle: h5Regular.copyWith(color: grey2Color),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: greyColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Nama Panggilan',
              style: textDescriptionSemiBold,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controller.nicknameC,
              cursorColor: black,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama Panggilan',
                hintStyle: h5Regular.copyWith(color: grey2Color),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: greyColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GenderSelector(
                      gender: Gender.male,
                      selectedGender: controller.selectedGender.value,
                      onSelect: (gender) {
                        controller.toggleGender(gender);
                        print(dateController.selectedDate);
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
            DatePicker(),
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
                    contentPadding: const EdgeInsets.all(16),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor),
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
                menuProps: MenuProps(
                  backgroundColor: whiteColor,
                  margin: const EdgeInsets.only(top: 12),
                  shape: const RoundedRectangleBorder(
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
                        style: controller.isSportTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
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
                        text: 'Art',
                        style: controller.isArtTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
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
                        text: 'Politics',
                        style: controller.isPoliticsTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
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
                        text: 'Anxiety',
                        style: controller.isAnxietyTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
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
                        text: 'Tech',
                        style: controller.isTechTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
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
                        text: 'Innovation',
                        style: controller.isInnovationTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
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
                        text: 'Lainnya',
                        style: controller.isLainnyaTap.value
                            ? h7SemiBold.copyWith(color: whiteColor)
                            : h7SemiBold.copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
                child: MyButton(
                    get: () {
                      controller.saveData();
                    },
                    color: primaryColor,
                    text: 'Lanjutkan'))
          ],
        ),
      ),
    );
  }
}
