import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

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
      body: Column(
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
                  TextField(
                    onChanged: (value) {
                      controller.isEmpty();
                    },
                    controller: controller.emailC,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Color(0xFFc4c4c4)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFc4c4c4))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => TextField(
                        onChanged: (value) {
                          controller.isEmpty();
                        },
                        obscureText: controller.isSecure.value,
                        controller: controller.passC,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Color(0xFFc4c4c4)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {
                              controller.showPassword();
                            },
                          ),
                          suffixIconColor: const Color(0xFFc4c4c4),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFc4c4c4))),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => TextField(
                        onChanged: (value) {
                          controller.isEmpty();
                        },
                        obscureText: controller.isSecureC.value,
                        controller: controller.confirmPassC,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Password',
                          hintStyle: const TextStyle(color: Color(0xFFc4c4c4)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {
                              controller.showPasswordC();
                            },
                          ),
                          suffixIconColor: const Color(0xFFc4c4c4),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFc4c4c4))),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 68,
                  ),
                  Obx(() => ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.ASSESMENT_1);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isButtonActive.value
                                ? const Color(0xFFc4c4c4)
                                : Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(
                              double.infinity,
                              44,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Daftar',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      )),
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
                        style:
                            GoogleFonts.poppins(color: const Color(0xFF60ABEE)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
