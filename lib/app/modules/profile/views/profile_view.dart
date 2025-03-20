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
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          side: BorderSide(color: Colors.black12),
        ),
        title: Text(
          'Profile',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
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
                          onPressed: () {
                            Get.toNamed(Routes.EDIT_PROFILE);
                          },
                        ),
                      ),
                    ],
                  ),
                  sby12,
                  Text(
                    box.read('nickname') ?? "Astro",
                    style: h3Bold,
                  ),
                ],
              ),
            ),
            sby36,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: h4Regular,
                ),
                sby16,
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
                sby16,
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
                sby16,
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.CONSULT_HISTORY),
                  child: Row(
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
                ),
                sby24,
                const Divider(),
                sby24,
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(
                      Routes.LOGIN,
                    );
                    box.erase();
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
