import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/auth_textfield.dart';

import '../../../themes/spaces.dart';
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
                    sby60,
                    Center(
                      child: Text(
                        'Login',
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
                    AuthTextfield(
                      onChanged: (value) => controller.isEmpty(),
                      showPassword: () => controller.showPassword(),
                      controller: controller.passC,
                      obscureText: controller.isSecure.value,
                      hintText: 'Password',
                      passwordField: true,
                      type: TextInputType.text,
                    ),
                    sby12,
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SEND_OTP);
                      },
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Text(
                          "Forgot password?",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins().copyWith(
                            color: const Color(0xFF60ABEE),
                          ),
                        ),
                      ),
                    ),
                    sby36,
                    ElevatedButton(
                      onPressed: () {
                        controller.login();
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
                        "Don't have account? ",
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.SIGNUP),
                        child: Text(
                          'Register',
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
