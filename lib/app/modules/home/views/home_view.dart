// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/modules/chat/views/chat_view.dart';
import 'package:temanbicara/app/modules/report/controllers/report_controller.dart';
import 'package:temanbicara/app/modules/report/views/report_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/mental_matrix.dart';
import 'package:temanbicara/app/widgets/my_journal.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../../journal/controllers/journal_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<ReportController> {
  GetStorage box = GetStorage();
  HomeView({super.key});
  final HomeController _controller = Get.put(HomeController());
  final ReportController reportController = Get.put(ReportController());
  final JournalController journalController = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            _controller.fetchData(),
            journalController.fetchJournals(),
          ]);
        },
        child: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            snap: true,
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
                  Get.toNamed(Routes.CHAT);
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
                                  'Hello, ${box.read('nickname')}',
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
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.TRACKING);
                                print(box.read('token'));
                              },
                              child: Text(
                                'Tracking',
                                style: trackingButton,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.REPORT),
                          child: Text(
                            'Mental Health Report',
                            style: h4SemiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.toNamed(Routes.REPORT),
                            child: MentalMatrix(
                              color: lightPurple,
                              title: 'Sleep Quality',
                              detail:
                                  "Status ${reportController.avgSleep.value}",
                              icon: const Icon(Iconsax.math),
                              iconColor: Colors.purple,
                              image: "assets/images/sleepquality.png",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.toNamed(Routes.REPORT),
                            child: MentalMatrix(
                              color: lightBlue,
                              title: 'Stress Level',
                              detail:
                                  "Level ${reportController.avgStress.value.toString()}",
                              icon: Icon(Iconsax.math),
                              iconColor: Colors.lightBlue,
                              image: "assets/images/stresslevel.png",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.toNamed(Routes.REPORT),
                            child: MentalMatrix(
                              color: lightYellow,
                              title: 'Mood Tracker',
                              detail:
                                  "Status ${reportController.avgMood.value}",
                              icon: Icon(Iconsax.math),
                              iconColor: Colors.yellow,
                              image: "assets/images/moodtracker.png",
                            ),
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
                                      text: 'Consult')
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
                        Obx(() {
                          if (journalController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (journalController.journalList.isEmpty) {
                            return Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return Container(
                              constraints: BoxConstraints(
                                maxHeight: 150,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    journalController.journalList.length <= 2
                                        ? journalController.journalList.length
                                        : 3,
                                itemBuilder: (BuildContext context, int i) {
                                  List journals = journalController.journalList;
                                  final journal = journals[i];

                                  int emotionIndex = journalController.emotions
                                      .indexOf(journal['mood_level']);
                                  Color emotionColor = journalController
                                      .emotionColors[emotionIndex];
                                  DateTime date =
                                      DateTime.parse(journals[i]['created_at']);
                                  return MyJournal(
                                    type: journal['mood_level'] ?? 'Unknown',
                                    colors: emotionColor,
                                    title: journal['title'] ?? 'No Title',
                                    date: journalController.formatDate(date),
                                  );
                                },
                              ),
                            );
                          }
                        }),
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
                    padding: const EdgeInsets.fromLTRB(32, 21, 32, 15),
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
                              onTap: () async {
                                final data = await _controller.articles;
                                Get.toNamed(
                                  Routes.ARTICLE,
                                  arguments: data['data'],
                                );
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
                ),
                Obx(() {
                  if (_controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (_controller.articles.isEmpty) {
                    return Center(
                      child: Text("No Data Available"),
                    );
                  } else {
                    final List articles = _controller.articles['data'];
                    final double containerHeight =
                        articles.length <= 2 ? articles.length * 180.0 : 530.0;
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: containerHeight,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: articles.length <= 2 ? articles.length : 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: TopArticle(
                              judul: articles[index]["title"],
                              deskripsi: articles[index]["content"],
                              author: articles[index]["user"]["name"],
                              image: articles[index]["image"],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
                sby24
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
