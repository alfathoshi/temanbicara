import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/assesment_1/controllers/assesment_1_controller.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/favorite_button.dart';

class form extends StatelessWidget {
  form({super.key});
  bool isMale = false;
  bool isFemail = false;
  bool gender = false;
  final Assesment1Controller _assesment1controller =
      Get.put(Assesment1Controller());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama',
          style: textDescriptionSemiBold,
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Masukan Nama Lengkap',
            hintStyle: textFieldStyle,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.black26,
                  width: 2,
                )),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Nama Panggilan',
          style: textDescriptionSemiBold,
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Masukan Nama Panggilan',
            hintStyle: textFieldStyle,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.black26,
                  width: 2,
                )),
          ),
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _assesment1controller.toggleGender(Gender.male); // Set to male
              },
              child: Obx(
                () => _assesment1controller.selectedGender.value == Gender.male
                    ? Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/male.png',
                              scale: 2,
                              color: whiteColor,
                            ),
                            SizedBox(width: 8),
                            Text('Pria', style: textGenderTrue),
                          ],
                        ),
                      )
                    : Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/male.png', scale: 2),
                            SizedBox(width: 8),
                            Text('Pria', style: textGenderFalse),
                          ],
                        ),
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _assesment1controller.toggleGender(Gender.female);
              },
              child: Obx(
                () => _assesment1controller.selectedGender.value ==
                        Gender.female
                    ? Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/female.png',
                              scale: 2,
                              color: whiteColor,
                            ),
                            SizedBox(width: 8),
                            Text('Wanita', style: textGenderTrue),
                          ],
                        ),
                      )
                    : Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/female.png', scale: 2),
                            SizedBox(width: 8),
                            Text('Wanita', style: textGenderFalse),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Tanggal',
          style: textDescriptionSemiBold,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(
              color: Colors.black26,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pilih Tanggal Lahir',
                style: textFieldStyle,
              ),
            ),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2010, 10, 16),
                lastDate: DateTime(2030, 3, 14),
                confirmText: "Pilih",
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: primaryColor,
                      colorScheme: ColorScheme.light(
                        primary: primaryColor,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
            },
          ),
        ),
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
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isSportTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isSportTap.value
                          ? primaryColor
                          : whiteColor,
                      text: 'Sport'),
                  FavoriteButton(
                      get: () {
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isArtTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isArtTap.value
                          ? primaryColor
                          : whiteColor,
                      text: 'Art'),
                  FavoriteButton(
                      get: () {
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isPoliticsTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isPoliticsTap.value
                          ? primaryColor
                          : whiteColor,
                      text: 'Politics'),
                  FavoriteButton(
                      get: () {
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isAnxietyTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isAnxietyTap.value
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
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isTechTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isTechTap.value
                          ? primaryColor
                          : whiteColor,
                      text: 'Tech'),
                  FavoriteButton(
                      get: () {
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isInnovationTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isInnovationTap.value
                          ? primaryColor
                          : whiteColor,
                      text: 'Innovation'),
                  FavoriteButton(
                      get: () {
                        _assesment1controller.toggleTopis();
                      },
                      colorBorder: _assesment1controller.isLainnyaTap.value
                          ? whiteColor
                          : primaryColor,
                      colorBackground: _assesment1controller.isLainnyaTap.value
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
            child: MyButton(get: () {}, color: primaryColor, text: 'Lanjutkan'))
      ],
    );
  }
}
