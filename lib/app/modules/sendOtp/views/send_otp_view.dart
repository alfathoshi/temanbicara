// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

import '../controllers/send_otp_controller.dart';

class SendOtpView extends GetView<SendOtpController> {
  const SendOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: Text(
          "Send OTP",
          style: h3Bold,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    Image.asset('assets/images/sendotp.png'),
                    const SizedBox(height: 16),
                    Text(
                      'OTP Verification',
                      style:
                          verifyOtpTextStyle(16, const Color(0xFF5B5B5B), true),
                    ),
                    Text(
                      'We will send you one-time password to your email',
                      style: verifyOtpTextStyle(14, black, false),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Enter your email',
                      style: verifyOtpTextStyle(16, black, true),
                    ),
                    sby8,
                    TextField(
                      onChanged: (value) {
                        controller.isButtonActive.value = value.isEmpty;
                      },
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF544C4C),
                            width: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    sby32,
                    Obx(
                      () => ElevatedButton(
                        onPressed: () async {
                          if (controller.emailController.value.text.isEmpty) {
                            CustomSnackbar.showSnackbar(
                              title: "Oops!",
                              message: "Please Fill the Field!",
                              status: false,
                            );
                            return;
                          }
                          await controller.sendOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: controller.isLoading.value == false
                            ? Text(
                                'Send OTP',
                                style: verifyOtpTextStyle(16, whiteColor, true),
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
            ),
          );
        },
      ),
    );
  }
}

TextStyle verifyOtpTextStyle(double size, Color color, bool isBold) {
  return GoogleFonts.poppins().copyWith(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    fontSize: size,
    color: color,
  );
}
