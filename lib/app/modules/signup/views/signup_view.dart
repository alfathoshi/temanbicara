import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
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
                            MinCharactersValidationRule(8).validate(value) &&
                                UppercaseValidationRule().validate(value) &&
                                LowercaseValidationRule().validate(value) &&
                                SpecialCharacterValidationRule()
                                    .validate(value);
                      },
                      validationRules: {
                        MinCharactersValidationRule(8),
                        UppercaseValidationRule(),
                        LowercaseValidationRule(),
                        SpecialCharacterValidationRule(),
                      },
                      validationRuleBuilder: (rules, value) {
                        bool allValid =
                            rules.every((rule) => rule.validate(value));
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.isPasswordValid.value = allValid;
                        });
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: rules
                              .map(
                                (rule) => rule.validate(value)
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: primaryColor,
                                          ),
                                          sby12,
                                          Text(
                                            rule.name,
                                            style: TextStyle(
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          sby12,
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                              .toList(),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: greyColor),
                        suffixIcon: true == true
                            ? IconButton(
                                icon: const Icon(Icons.remove_red_eye_outlined),
                                onPressed: () => controller.showPassword(),
                              )
                            : null,
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
                      hintText: 'Password',
                      passwordField: true,
                      type: TextInputType.text,
                    ),
                    sby60,
                    sby8,
                    ElevatedButton(
                      onPressed: controller.isButtonActive.value &&
                              controller.isPasswordValid.value
                          ? () => controller.register()
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isButtonActive.value
                              ? primaryColor
                              : const Color(0xFFc4c4c4),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                            double.infinity,
                            44,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
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
