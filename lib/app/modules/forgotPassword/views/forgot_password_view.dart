// ignore_for_file: unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/utils/validation.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/password_validation.dart';
import '../controllers/forgot_password_controller.dart';
import 'package:fancy_password_field/fancy_password_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: CustomAppBar(
          backLeading: false,
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
                        Text('New Password', style: textDescriptionSemiBold),
                        sby8,
                        Obx(() => FancyPasswordField(
                              controller: controller.newPasswordController,
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
                                  borderSide:
                                      const BorderSide(color: greyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                            )),
                        sby12,
                        Text('Confirm Password',
                            style: textDescriptionSemiBold),
                        sby8,
                        Obx(
                          () => AuthTextfield(
                            onChanged: (value) {},
                            showPassword: () => controller.showPasswordC(),
                            controller: controller.confirmPasswordController,
                            obscureText: controller.isConfPassObscure.value,
                            hintText: 'Password',
                            passwordField: true,
                            type: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sby36,
              Obx(() => ElevatedButton(
                    onPressed: () {
                      controller.changePassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: whiteColor),
                          )
                        : Text(
                            'Confirm',
                            style: h4Bold.copyWith(color: whiteColor),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget changePasswordTextfield(
    String hint, TextEditingController textController, RxBool isObscure) {
  return Obx(() => TextField(
        obscureText: isObscure.value,
        controller: textController,
        cursorColor: black,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              isObscure.value = !isObscure.value;
            },
            child: Icon(
              isObscure.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
            ),
          ),
          hintText: hint,
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
      ));
}
