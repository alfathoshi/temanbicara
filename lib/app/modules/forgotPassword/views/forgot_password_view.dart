import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
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
                          'New Password',
                          style: textDescriptionSemiBold,
                        ),
                        sby8,
                        TextField(
                          obscureText: controller.isNewPassObscure.value,
                          controller: controller.newPasswordController,
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
                        sby12,
                        Text(
                          'Confirm Password',
                          style: textDescriptionSemiBold,
                        ),
                        sby8,
                        TextField(
                          obscureText: controller.isConfPassObscure.value,
                          controller: controller.confirmPasswordController,
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
            ),
            sby24,
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  await controller.changePassword();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isButtonActive.value
                        ? const Color(0xFFc4c4c4)
                        : primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      44,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: controller.isLoading.value == false
                    ? Text(
                        'Confirm',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      )
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: whiteColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
