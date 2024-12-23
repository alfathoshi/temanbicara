import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
   ProfileView({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 65, 32, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: border,
                        child: CircleAvatar(
                          radius: 58,
                          backgroundColor: whiteColor,
                          child: Image.asset(
                            'assets/images/profile.png',
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 16,
                            color: whiteColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    box.read('nickname'),
                    style: h3Bold,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: h4Regular,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: h4SemiBold,
                      ),
                      const Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Password',
                        style: h4SemiBold,
                      ),
                      const Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_LANGUAGE);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Language',
                        style: h4SemiBold,
                      ),
                      const Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Consultations History',
                      style: h4SemiBold,
                    ),
                    const Icon(
                      Icons.chevron_right_outlined,
                      size: 32,
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'More',
                      style: h4Regular,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About us',
                      style: h4SemiBold,
                    ),
                    const Icon(
                      Icons.chevron_right_outlined,
                      size: 32,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: h4SemiBold,
                    ),
                    const Icon(
                      Icons.chevron_right_outlined,
                      size: 32,
                    )
                  ],
                ),
                sby36,
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(
                      Routes.LOGIN,
                    );
                  },
                  child: Text(
                    'Logout',
                    style: h4SemiBold.copyWith(color: error),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
