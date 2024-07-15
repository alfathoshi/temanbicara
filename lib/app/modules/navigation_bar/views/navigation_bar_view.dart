import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/modules/article/views/article_view.dart';
import 'package:temanbicara/app/modules/chatbot/views/chatbot_view.dart';
import 'package:temanbicara/app/modules/consult/views/consult_view.dart';
import 'package:temanbicara/app/modules/profile/views/profile_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../../home/views/home_view.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  final List<Widget> _pages = [
    HomeView(),
    ArticleView(),
    ChatbotView(),
    ConsultView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedindex.value,
            children: _pages,
          )),
      bottomNavigationBar: SizedBox(
        height: 72,
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedindex.value,
            onTap: (index) {
              controller.changeIndex(index);
            },
            backgroundColor: whiteColor,
            selectedItemColor: primaryColor,
            selectedLabelStyle: h6Bold,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.book), label: 'Article'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.emoji_happy), label: 'Chatbot'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.message), label: 'Consult'),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
