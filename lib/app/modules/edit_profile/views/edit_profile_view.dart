import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/date.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});

  final EditProfileController _controller = Get.put(EditProfileController());

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
      body: Padding(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  TextField(
                    controller: controller.nameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama',
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
                      hintText: 'Masukkan Nama Lengkap',
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
                    'Tanggal Lahir',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  Obx(() => FlexibleDatePicker(
                        selectedDate: controller.selectedDate.value,
                        onDateChanged: (picked) {
                          controller.updateDate(picked);
                        },
                        placeholder: 'Tanggal Lahir',
                      )),
                  sby16,
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () async {
                  await _controller.editProfile();

                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 4});
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor),
                  foregroundColor: WidgetStatePropertyAll(whiteColor),
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
