import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../themes/spaces.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/date.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Edit Profile",
          style: h3Bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              sby24,
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: border,
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: whiteColor,
                        backgroundImage: NetworkImage(controller.profileUrl),
                      ),
                    ),
                  ],
                ),
              ),
              sby36,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  TextField(
                    controller: controller.nameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Enter your name...',
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
                  sby16,
                  Text(
                    'Nickname',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  TextField(
                    controller: controller.nicknameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Enter your nickname...',
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
                  sby16,
                  Text(
                    'Email',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  TextField(
                    enabled: false,
                    controller: controller.emailController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
                      hintStyle: h5Regular.copyWith(color: grey2Color),
                      disabledBorder: OutlineInputBorder(
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
                  sby16,
                  Text(
                    'Birthdate',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  Obx(() => FlexibleDatePicker(
                        selectedDate: controller.selectedDate.value,
                        onDateChanged: (picked) {
                          controller.updateDate(picked);
                        },
                        placeholder: 'Birthdate',
                      )),
                  sby16,
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () async {
                    bool isSuccess = await controller.editProfile();
                    isSuccess
                        ? Get.offAllNamed(Routes.NAVIGATION_BAR,
                            arguments: {"indexPage": 4})
                        : '';
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    foregroundColor: WidgetStatePropertyAll(whiteColor),
                  ),
                  child: Text(
                    'Save',
                    style: h4Bold.copyWith(color: whiteColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
