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
  final JournalController fetchJournalController = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
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
                            detail: "Status ${reportController.avgSleep.value}",
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
                            detail: "Status ${reportController.avgMood.value}",
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
                      FutureBuilder(
                        future: _controller.fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            final List listData = snapshot.data!['data'];
                            final double containerHeight = 150;
                            if (listData.isEmpty) {
                              return Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 100,
                                ),
                                child: const Center(
                                  child: Text("Tidak Ada Data"),
                                ),
                              );
                            }
                            return Container(
                              constraints: BoxConstraints(
                                maxHeight: containerHeight,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    listData.length <= 2 ? listData.length : 3,
                                itemBuilder: (BuildContext context, int i) {
                                  List journals =
                                      fetchJournalController.journalList;
                                  int maxItems =
                                      journals.length < 5 ? journals.length : 5;
                                  int emotionIndex = fetchJournalController
                                      .emotions
                                      .indexOf(journals[i]['mood_level']);
                                  Color emotionColor = fetchJournalController
                                      .emotionColors[emotionIndex];
                                  DateTime date =
                                      DateTime.parse(journals[i]['created_at']);
                                  return MyJournal(
                                    type:
                                        journals[i]['mood_level'] ?? 'Unknown',
                                    colors: emotionColor,
                                    title: journals[i]['title'] ?? 'No Title',
                                    date: fetchJournalController.formatDate(date),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Container(
                              constraints: const BoxConstraints(
                                maxHeight: 180,
                              ),
                              child: const Center(
                                child: Text("Tidak Ada Data"),
                              ),
                            );
                          }
                        },
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
                            onTap: () async {
                              final data = await _controller.fetchData();
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
              FutureBuilder(
                future: _controller.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    final List listData = snapshot.data!['data'];
                    final double containerHeight =
                        listData.length <= 2 ? listData.length * 180.0 : 530.0;
                    if (listData.isEmpty) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                        ),
                        child: const Center(
                          child: Text("Tidak Ada Data"),
                        ),
                      );
                    }
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: containerHeight,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listData.length <= 2 ? listData.length : 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: TopArticle(
                              judul: listData[index]["title"],
                              deskripsi: listData[index]["content"],
                              author: listData[index]["user"]["name"],
                              image: listData[index]["image"],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                      constraints: const BoxConstraints(
                        maxHeight: 180,
                      ),
                      child: const Center(
                        child: Text("Tidak Ada Data"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),

        // SliverList.builder(
        //     itemCount: _controller.articleList.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: EdgeInsets.only(left: 24, right: 24),
        //         child: TopArticle(
        //           judul: _controller.articleList[index]["title"],
        //           deskripsi: _controller.articleList[index]["content"],
        //           author: _controller.articleList[index]["user"]["name"],
        //           image: _controller.articleList[index]["image"],
        //         ),
        //       );
        //     })
      ]),
    );
  }
}
