// ignore_for_file: unused_element

import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/utils/validation.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';
import 'package:temanbicara/app/widgets/password_validation.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  Widget? _buildSuffixIcon() {
    return IconButton(
      icon: Icon(
        controller.isSecure.value
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: 20,
        color: black,
      ),
      onPressed: () => controller.showPassword(),
    );
  }

  bool _isFormValid() {
    return controller.isButtonActive.value && controller.isPasswordValid.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          side: BorderSide(color: Colors.black12),
        ),
        toolbarHeight: 85,
        backgroundColor: primaryColor,
        title: Image.asset(
          'assets/images/logo.png',
          color: whiteColor,
          scale: 4,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sby60,
                      Center(
                        child: Text(
                          'Register',
                          style: h1Bold,
                        ),
                      ),
                      sby36,
                      AuthTextfield(
                        onChanged: (value) => controller.isEmpty(),
                        showPassword: () {},
                        controller: controller.emailC,
                        obscureText: false,
                        hintText: 'Email',
                        passwordField: false,
                        type: TextInputType.emailAddress,
                      ),
                      sby16,
                      FancyPasswordField(
                        obscureText: controller.isSecure.value,
                        controller: controller.passC,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          controller.isEmpty();
                          controller.isPasswordValid.value =
                              ValidationUtils.isPasswordValid(value);
                        },
                        validationRules: ValidationUtils.passwordRules,
                        validationRuleBuilder: (rules, value) {
                          return PasswordValidationView(
                              rules: rules, value: value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: h4Regular.copyWith(color: grey4Color),
                          suffixIcon: _buildSuffixIcon(),
                          suffixIconColor: const Color(0xFFc4c4c4),
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
                      AuthTextfield(
                        onChanged: (value) => controller.isEmpty(),
                        showPassword: () => controller.showPasswordC(),
                        controller: controller.confirmPassC,
                        obscureText: controller.isSecureC.value,
                        hintText: 'Confirm Password',
                        passwordField: true,
                        type: TextInputType.text,
                      ),
                      sby60,
                      sby8,
                      ElevatedButton(
                        onPressed: () {
                          // print(
                          // controller.validateEmail(controller.emailC.text));
                          controller.register();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(
                              double.infinity,
                              56,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: controller.isLoading.value == false
                            ? Text(
                                'Register',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              )
                            : SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: whiteColor,
                                ),
                              ),
                      ),
                      sby24,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account? ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF60ABEE),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
