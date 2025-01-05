import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});

  final ChangePasswordController _controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Change Password',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 375,
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.oldPassController,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password Lama',
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
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Menempatkan di kanan
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: h6Medium.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'New Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.newPassController,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password Baru',
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
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Confirm Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.confirmPassController,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Password',
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                get: () {
                  _controller.changePassword();
                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 4});
                },
                color: primaryColor,
                text: 'Simpan')
          ],
        ),
      ),
    );
  }
}
