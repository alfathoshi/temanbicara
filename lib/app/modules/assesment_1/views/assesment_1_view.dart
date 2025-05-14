import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import '../../../widgets/date.dart';
import '../../../widgets/gender_selector.dart';
import '../controllers/assesment_1_controller.dart';

class Assesment1View extends GetView<Assesment1Controller> {
  const Assesment1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(87),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                24, MediaQuery.of(context).padding.top + 24, 24, 24),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 25,
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Let’s get to know you better!', style: h3Bold),
                      Text('Fill in your personal info to start the journey',
                          style: h5Regular),
                      sby32,
                      Text('Name', style: textDescriptionSemiBold),
                      sby8,
                      TextField(
                        controller: controller.nameC,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Enter your fullname',
                          hintStyle: h5Regular.copyWith(color: grey2Color),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                      sby24,
                      Text('Nickname', style: textDescriptionSemiBold),
                      sby8,
                      TextField(
                        controller: controller.nicknameC,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Enter your nickname',
                          hintStyle: h5Regular.copyWith(color: grey2Color),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                      sby24,
                      Text('Phone Number', style: textDescriptionSemiBold),
                      sby8,
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            cursorColor: black,
                            controller: controller.phoneC,
                            decoration: InputDecoration(
                              prefix: const SizedBox(width: 50),
                              hintText: 'Enter your phone number',
                              hintStyle: h5Regular.copyWith(color: greyColor),
                              suffixIconColor: const Color(0xFFc4c4c4),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: primaryColor,
                              child: Center(
                                child: Text('+62',
                                    style: h5Bold.copyWith(color: whiteColor)),
                              ),
                            ),
                          )
                        ],
                      ),
                      sby24,
                      Text('Gender', style: textDescriptionSemiBold),
                      sby8,
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GenderSelector(
                              gender: Gender.male,
                              selectedGender: controller.selectedGender.value,
                              onSelect: (gender) =>
                                  controller.toggleGender(gender),
                            ),
                            GenderSelector(
                              gender: Gender.female,
                              selectedGender: controller.selectedGender.value,
                              onSelect: (gender) =>
                                  controller.toggleGender(gender),
                            )
                          ],
                        ),
                      ),
                      sby24,
                      Text('Birthdate', style: textDescriptionSemiBold),
                      sby8,
                      Obx(() => FlexibleDatePicker(
                            selectedDate: controller.selectedDate.value,
                            onDateChanged: (picked) {
                              controller.updateDate(picked);
                            },
                            placeholder: 'Tanggal Lahir',
                          )),
                      sby24,
                      const Expanded(child: SizedBox()),
                      Obx(() => ElevatedButton(
                            onPressed: () {
                              controller.saveAssesment();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 44),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: controller.isLoading.value == false
                                ? Text('Next',
                                    style: h5Bold.copyWith(color: whiteColor))
                                : SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: whiteColor),
                                  ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
