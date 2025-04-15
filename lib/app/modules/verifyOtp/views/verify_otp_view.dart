import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Verify OTP',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              Image.asset('assets/images/sendotp.png'),
              const SizedBox(
                height: 16,
              ),
              Text(
                'OTP Verification',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF5B5B5B),
                ),
              ),
              Text(
                'Enter the OTP that sent to ${controller.email}',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              sby24,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(6, (index) {
                    return Obx(
                      () => buildOtpField(index, controller, context),
                    );
                  }),
                ),
              ),
              sby16,
              Obx(
                () => Text(
                  'Incorrect OTP, try again',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: controller.isCorrect.value
                        ? Colors.white
                        : const Color(0xFFFF8B7B),
                  ),
                ),
              ),
              sby32,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn\'t receive the OTP email? ',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 14,
                        color: const Color(0xFF7E954E),
                      ),
                    ),
                    TextSpan(
                      text: 'Resend OTP!',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xFF7E954E),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => controller.sendOtp(),
                    ),
                  ],
                ),
              ),
              sby32,
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    controller.isLoading.value = true;
                    if (!controller.isButtonActive.value) {
                      // Get.toNamed(Routes.FORGOT_PASSWORD);
                      await controller.verifyOtp();
                    }
                    controller.isLoading.value = false;
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
                          'Verify',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
  }
}

Widget buildOtpField(int index, var controller, var context) {
  return SizedBox(
    width: 50,
    height: 50,
    child: TextField(
      enabled: index == controller.focusedIndex.value,
      controller: controller.controllers[index],
      focusNode: controller.focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      onChanged: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.focusNodes[controller.focusedIndex.value].requestFocus();
        });

        if (value.isNotEmpty && index < 5) {
          controller.focusedIndex.value = index + 1;
          FocusScope.of(context).requestFocus(controller.focusNodes[index + 1]);
        } else if (value.isEmpty && index > 0) {
          controller.isButtonActive.value = true;
          controller.focusedIndex.value = index - 1;
          FocusScope.of(context).requestFocus(controller.focusNodes[index - 1]);
        }

        if (index == 5) controller.isButtonActive.value = false;
      },
      decoration:
          const InputDecoration(counterText: '', border: OutlineInputBorder()),
    ),
  );
}
