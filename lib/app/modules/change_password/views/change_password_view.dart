import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: h3Bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 375,
                width: 350,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: oldPassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Menempatkan di kanan
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: h6Medium.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'New Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: newPassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Confirm Password',
                        style: textDescriptionSemiBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: confirmPassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                get: () {
                  Get.toNamed(Routes.PROFILE);
                },
                color: primaryColor,
                text: 'Change Password')
          ],
        ),
      ),
    );
  }
}
