import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
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
        body: ListView(
          children: [
            Obx(
              () => Container(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                              child: Text(
                                'Sign Up',
                                style: h1Bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AuthTextfield(
                              onChanged: (value) => controller.isEmpty(),
                              showPassword: () {},
                              controller: controller.emailC,
                              obscureText: false,
                              hintText: 'Email',
                              passwordField: false,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AuthTextfield(
                              onChanged: (value) => controller.isEmpty(),
                              showPassword: () {},
                              controller: controller.phoneC,
                              obscureText: false,
                              hintText: 'Phone Number',
                              passwordField: false,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AuthTextfield(
                              onChanged: (value) => controller.isEmpty(),
                              showPassword: () => controller.showPassword(),
                              controller: controller.passC,
                              obscureText: controller.isSecure.value,
                              hintText: 'Password',
                              passwordField: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            AuthTextfield(
                              onChanged: (value) => controller.isEmpty(),
                              showPassword: () => controller.showPasswordC(),
                              controller: controller.confirmPassC,
                              obscureText: controller.isSecureC.value,
                              hintText: 'Password',
                              passwordField: true,
                            ),
                            const SizedBox(
                              height: 68,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.register();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.isButtonActive.value
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
                                      'Daftar',
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
                            const SizedBox(
                              height: 24,
                            ),
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
                                'Sudah punya akun? ',
                                style: GoogleFonts.poppins(),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.LOGIN),
                                child: Text(
                                  'Masuk',
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
                        'Sudah punya akun? ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                        child: Text(
                          'Masuk',
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
        ));
  }
}
