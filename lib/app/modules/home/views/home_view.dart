import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/mental_matrix.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teman',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                Text(
                  'Bicara',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/send.png',
              scale: 0.9,
            ),
          ),
        ],
      ),
      backgroundColor: border,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: border,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: whiteColor,
                            child: Image.asset(
                              'assets/images/profile.png',
                              scale: 2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, User',
                              style: h3SemiBold,
                            ),
                            Text(
                              'How${"'s"} your day?',
                              style: h4Regular,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Tracking',
                          style: trackingButton,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Mental Health Matrix',
                      style: h4SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consultation',
                      style: h4SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Chatbot',
                      style: h4SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Journal',
                      style: h4SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Article',
                      style: h4SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MentalMatrix(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
