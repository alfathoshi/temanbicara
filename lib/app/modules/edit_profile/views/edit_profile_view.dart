import 'dart:collection';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
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
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Edit Profile',
          style: h3Bold,
        ),
        centerTitle: true,
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
                      child: Image.asset(
                        'assets/images/profile.png',
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: whiteColor,
                      ),
                      onPressed: () {},
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
                  sby16,
                  Text(
                    'Email',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  TextField(
                    controller: controller.emailController,
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
                  sby16,
                  Text(
                    'Tanggal Lahir',
                    style: textDescriptionSemiBold,
                  ),
                  sby8,
                  DatePicker(),
                  //const SizedBox(
                  //  height: 16,
                  // ),
                  // Text(
                  //   'Negara',
                  //   style: textDescriptionSemiBold,
                  // ),
                  // sby8,
                  // DropdownSearch<String>(
                  //   items: (filter, infiniteScrollProps) => [
                  //     'Indonesia',
                  //     'Singapore',
                  //     'Malaysia',
                  //     'Jepang',
                  //     'Korea'
                  //   ],
                  //   suffixProps: const DropdownSuffixProps(
                  //     dropdownButtonProps: DropdownButtonProps(
                  //       iconClosed: Icon(Icons.keyboard_arrow_down),
                  //       iconOpened: Icon(Icons.keyboard_arrow_up),
                  //     ),
                  //   ),
                  //   decoratorProps: DropDownDecoratorProps(
                  //     decoration: InputDecoration(
                  //         contentPadding: const EdgeInsets.all(15),
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(16),
                  //           borderSide: const BorderSide(
                  //             color: Colors.black26,
                  //             width: 2,
                  //           ),
                  //         ),
                  //         hintText: 'pilih negara',
                  //         hintStyle: textFieldStyle),
                  //   ),
                  //   popupProps: PopupProps.menu(
                  //     itemBuilder:
                  //         (context, item, isDisabled, isSelected) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(15),
                  //         child: Text(
                  //           item,
                  //           style: textFieldStyle,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       );
                  //     },
                  //     constraints: const BoxConstraints(maxHeight: 160),
                  //     menuProps: const MenuProps(
                  //       margin: EdgeInsets.only(top: 12),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(12))),
                  //     ),
                  //   ),
                  //   onChanged: (country) {
                  //     controller.setCountry(country ?? '');
                  //   },
                  //   selectedItem: controller.selectedCountry.value,
                  // ),
                  sby16,
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  _controller.editProfile();
                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 4});
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor),
                  foregroundColor: WidgetStatePropertyAll(whiteColor),
                ),
                child: const Text('Simpan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
