import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/modules/chatbot/views/chatbot_view.dart';
import 'package:temanbicara/app/modules/consult/views/consult_view.dart';
import 'package:temanbicara/app/modules/journal/views/journal_view.dart';
import 'package:temanbicara/app/modules/profile/views/profile_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../../home/views/home_view.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  final indexPage = Get.arguments;

  final List<Widget> _pages = [
    HomeView(),
    const JournalView(),
    Container(),
    ConsultView(),
    ProfileView(),
  ];

  NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _pages[controller.selectedindex.value],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CHATBOT_ROOM);
        },
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        child: const Icon(Iconsax.emoji_happy),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedindex.value,
          onTap: (index) {
            if (index == 2) return;
            controller.changeIndex(index);
          },
          backgroundColor: whiteColor,
          selectedItemColor: primaryColor,
          selectedLabelStyle: h6Bold,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book),
              label: 'Journal',
            ),
            BottomNavigationBarItem(
              icon: IgnorePointer(child: Icon(Icons.add)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.message),
              label: 'Consult',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
