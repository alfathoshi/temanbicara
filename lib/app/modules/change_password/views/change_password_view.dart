// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

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
      appBar: CustomAppBar(
        title: Text(
          "Change Password",
          style: h3Bold,
        ),
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
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: textDescriptionSemiBold,
                        ),
                        sby8,
                        TextField(
                          obscureText: controller.isOldPassObscure.value,
                          controller: controller.oldPassController,
                          cursorColor: black,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTapUp: (_) {
                                controller.isOldPassObscure.value = true;
                              },
                              onTapDown: (_) {
                                controller.isOldPassObscure.value = false;
                              },
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 20,
                              ),
                            ),
                            hintText: 'Enter current password',
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
                              onPressed: () {
                                Get.toNamed(Routes.SEND_OTP);
                              },
                              child: Text(
                                'Forget Password?',
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
                        sby8,
                        TextField(
                          obscureText: controller.isNewPassObscure.value,
                          controller: controller.newPassController,
                          cursorColor: black,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTapUp: (_) {
                                controller.isNewPassObscure.value = true;
                              },
                              onTapDown: (_) {
                                controller.isNewPassObscure.value = false;
                              },
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 20,
                              ),
                            ),
                            hintText: 'Enter new password',
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
                        sby12,
                        Text(
                          'Confirm New Password',
                          style: textDescriptionSemiBold,
                        ),
                        sby8,
                        TextField(
                          obscureText: controller.isConfPassObscure.value,
                          controller: controller.confirmPassController,
                          cursorColor: black,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTapUp: (_) {
                                controller.isConfPassObscure.value = true;
                              },
                              onTapDown: (_) {
                                controller.isConfPassObscure.value = false;
                              },
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 20,
                              ),
                            ),
                            hintText: 'Re-enter the new password',
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
            ),
            sby24,
            MyButton(
                get: () async {
                  bool isSuccess = await _controller.changePassword();
                  if (isSuccess) {
                    Get.offAllNamed(Routes.NAVIGATION_BAR,
                        arguments: {"indexPage": 4});
                  }
                },
                color: primaryColor,
                text: 'Simpan')
          ],
        ),
      ),
    );
  }
}
