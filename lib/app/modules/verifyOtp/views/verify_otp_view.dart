import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify OTP',
          style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
                'Enter the OTP that sent to ${Get.arguments['email']}',
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
                      () => buildOtpField(index, controller.controllers,
                          controller.focusNodes, context, controller),
                    );
                  }),
                ),
              ),
              sby16,
              Text(
                'Incorrect OTP, try again',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xFFFF8B7B),
                ),
              ),
              sby32,
              Text(
                'Didn\'t receive the OTP email? Resend OTP!',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 14,
                  color: const Color(0xFF7E954E),
                ),
              ),
              sby32,
              ElevatedButton(
                onPressed: () {
                  // Get.toNamed(Routes.VERIFY_OTP);
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
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      )
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: whiteColor,
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

Widget buildOtpField(
    int index, var controllers, var focusNodes, var context, var controller) {
  return SizedBox(
    width: 50,
    height: 50,
    child: TextField(
      enabled: index == controller.focusedIndex.value,
      controller: controllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      onChanged: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNodes[controller.focusedIndex.value].requestFocus();
        });
        print(controller.focusedIndex.value);
        //This condition ensures that the current TextField is not the last one in the sequence.
        //The check index < 5 prevents trying to move focus to a non-existent next field.
        if (value.isNotEmpty && index < 5) {
          controller.focusedIndex.value = index + 1;
          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
        }
        //managing focus in an OTP input field where the user may need to move backward when correcting an entry
        else if (value.isEmpty && index > 0) {
          controller.focusedIndex.value = index - 1;
          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
        }
      },
      decoration:
          const InputDecoration(counterText: '', border: OutlineInputBorder()),
    ),
  );
}
