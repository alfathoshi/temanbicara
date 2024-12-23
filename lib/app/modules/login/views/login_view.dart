import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Text(
                        'Login',
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
                      hintText: 'Email / Username',
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
                      height: 68,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.login(
                            controller.emailC.text, controller.passC.text);
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
                              'Masuk',
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
                        'Belum punya akun? ',
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SIGNUP),
                        child: Text(
                          'Daftar',
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
