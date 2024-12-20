import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/modules/chat/views/chat_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/mental_matrix.dart';
import 'package:temanbicara/app/widgets/my_journal.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatView()));
              },
              icon: Image.asset(
                'assets/icons/send.png',
                scale: 0.9,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: whiteColor,
                    border: BorderDirectional(
                        bottom: BorderSide(
                      color: border,
                    ))),
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
                      const MentalMatrix(
                        color: lightGreen,
                        title: 'Mental Health Matrix',
                        detail: '84% Healthy',
                        icon: Icon(Iconsax.math),
                        iconColor: Colors.green,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MentalMatrix(
                        color: lightPurple,
                        title: 'Sleep Quality',
                        detail: '84% Healthy',
                        icon: Icon(Iconsax.math),
                        iconColor: Colors.purple,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MentalMatrix(
                        color: lightBlue,
                        title: 'Stress Level',
                        detail: '84% Healthy',
                        icon: Icon(Iconsax.math),
                        iconColor: Colors.lightBlue,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const MentalMatrix(
                        color: lightYellow,
                        title: 'Mood Tracker',
                        detail: '84% Healthy',
                        icon: Icon(Iconsax.math),
                        iconColor: Colors.yellow,
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
                  border: Border.all(color: border),
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
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/consultHome.png',
                            scale: 3.2,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Do you need an expert?',
                                  style: h6SemiBold,
                                ),
                                Text(
                                  'Talk about your problems \nwith a professional psychologist',
                                  style: h7Regular,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                MyButton(
                                    get: () => Get.offAllNamed(
                                        Routes.NAVIGATION_BAR,
                                        arguments: {"indexPage": 3}),
                                    color: primaryColor,
                                    text: 'Consult Now')
                              ],
                            ),
                          )
                        ],
                      ),
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
                  border: Border.all(color: border),
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
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/chatbotHome.png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(28),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: lightBlue,
                                  ),
                                  child: Text(
                                    '“I’m so sorry \nabout your cat. \nAre you okay \nright now? \nWanna talk?”',
                                    style: h6Regular,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                MyButton(
                                    get: () => Get.offAllNamed(
                                        Routes.NAVIGATION_BAR,
                                        arguments: {"indexPage": 2}),
                                    color: Colors.lightBlue,
                                    text: 'Talk')
                              ],
                            ),
                          )
                        ],
                      ),
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
                  border: Border.all(color: border),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Journal',
                            style: h4SemiBold,
                          ),
                          GestureDetector(
                            onTap: () {
                               Get.offAllNamed(Routes.NAVIGATION_BAR,
                                  arguments: {"indexPage": 1});
                            },
                            child: Text(
                              'See More',
                              style: h4SemiBoldPrime,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 4; i++) const MyJournal(),
                          ],
                        ),
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
                  border: BorderDirectional(
                      top: BorderSide(
                    color: border,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Article',
                            style: h4SemiBold,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ARTICLE);
                            },
                            child: Text(
                              'See More',
                              style: h4SemiBoldPrime,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SliverList.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: TopArticle(
                  judul: data[index]["judul"],
                  deskripsi: data[index]["deskripsi"],
                  author: data[index]["author"],
                  image: data[index]["image"],
                ),
              );
            })
      ]),
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    "image": "article1",
    "judul": "What is mental health?",
    "deskripsi":
        "Mental health is about how people think, feel, and behave. Mental health care professionals can help people manage conditions such as depression, anxiety, bipolar disorder, addiction, and other disorders that affect their thoughts, feelings, and behaviors,Mental health can affect a person’s day-to-day life, relationships, and physical health. External factors in people’s lives and relationships can also contribute to their mental well-being.Looking after one’s mental health can help a person maintain their ability to enjoy life. This involves balancing their activities, responsibilities, and efforts to achieve psychological resilience.Stress, depression, and anxiety can affect mental health and may disrupt a person’s routine.Although healthcare professionals often use the term “mental health,” doctors recognize that many mental health conditions have physical roots.This article explains what mental health and mental health conditions mean. It also describes the most common types of mental health disorders, including their early signs and how to treat them.",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  },
  {
    "image": "article1",
    "judul": "a",
    "deskripsi": "loremipsum",
    "author": "gina cantik"
  }
];
