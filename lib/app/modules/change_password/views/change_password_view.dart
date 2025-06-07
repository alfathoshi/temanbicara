// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures

import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/utils/validation.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/password_validation.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Change Password",
          style: h3Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Password',
                            style: textDescriptionSemiBold),
                        sby8,
                        Obx(() => AuthTextfield(
                              onChanged: (value) {},
                              showPassword: () => controller.showPasswordOld(),
                              controller: controller.oldPassController,
                              obscureText: controller.isOldPassObscure.value,
                              hintText: 'Old Password',
                              passwordField: true,
                              type: TextInputType.text,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.SEND_OTP);
                              },
                              child: Text(
                                'Forget Password?',
                                style: h6Medium.copyWith(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        Text('New Password', style: textDescriptionSemiBold),
                        sby8,
                        Obx(() => FancyPasswordField(
                              controller: controller.newPassController,
                              keyboardType: TextInputType.text,
                              obscureText: controller.isNewPassObscure.value,
                              onChanged: (value) {
                                controller.isPasswordValid.value =
                                    ValidationUtils.isPasswordValid(value);
                                controller.isButtonActive.value =
                                    value.isNotEmpty;
                              },
                              validationRules: ValidationUtils.passwordRules,
                              validationRuleBuilder: (rules, value) {
                                return PasswordValidationView(
                                    rules: rules, value: value);
                              },
                              decoration: InputDecoration(
                                hintText: "Enter New Password",
                                hintStyle:
                                    h4Regular.copyWith(color: grey4Color),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isNewPassObscure.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    controller.isNewPassObscure.value =
                                        !controller.isNewPassObscure.value;
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: greyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                            )),
                        sby12,
                        Text('Confirm New Password',
                            style: textDescriptionSemiBold),
                        sby8,
                        Obx(() => AuthTextfield(
                              onChanged: (value) {},
                              showPassword: () => controller.showPasswordConf(),
                              controller: controller.confirmPassController,
                              obscureText: controller.isConfPassObscure.value,
                              hintText: 'Confirm New Password',
                              passwordField: true,
                              type: TextInputType.text,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              sby24,
              MyButton(
                get: () async {
                  bool isSuccess = await controller.changePassword();
                  if (isSuccess) {
                    Get.offAllNamed(Routes.NAVIGATION_BAR,
                        arguments: {"indexPage": 4});
                  }
                },
                color: primaryColor,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
