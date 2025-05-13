import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temanbicara/app/modules/report/controllers/report_controller.dart';
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

// ignore: must_be_immutable
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
            reportController.checkTracking()
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
                                  'Hello, ${box.read('name')}',
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
                            onTap: () {
                              if (controller.isTrackingFilled.value) {
                                Get.toNamed(Routes.REPORT);
                              } else {
                                Get.toNamed(Routes.NEW_TRACKING);
                              }
                            },
                            child: MentalMatrix(
                              color: lightGreen,
                              icon: const Icon(Icons.edit),
                              image: 'assets/images/limiter.png',
                              title: controller.title.value.isNotEmpty
                                  ? controller.title.value
                                  : '',
                              detail: controller.detail.value.isNotEmpty
                                  ? controller.detail.value
                                  : 'Complete your tracking to see your mental matrix.',
                              matrixValue: controller.isTrackingFilled.value
                                  ? controller.matrixValue.value
                                  : '',
                              isFilled: controller.isTrackingFilled.value,
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
                                      get: () =>
                                          Get.toNamed(Routes.CHATBOT_ROOM),
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
                            return const Center(child: CircularProgressIndicator());
                          } else if (journalController.journalList.isEmpty) {
                            return const Center(
                              child: Text("No Journal Today"),
                            );
                          } else {
                            return Container(
                              constraints: const BoxConstraints(
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
                                  DateTime date =
                                      DateTime.parse(journals[i]['created_at']);
                                  return MyJournal(
                                    type: 'Journal',
                                    colors: primaryColor,
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
                                final data = _controller.articles;
                                Get.toNamed(
                                  Routes.ARTICLE,
                                  arguments: data['data'] ?? [],
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (_controller.articles.isEmpty) {
                    return const Center(
                      child: Text("No Data Available"),
                    );
                  } else {
                    final List articles = _controller.articles['data'] ?? [];
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
                              image: articles[index]["image"] ?? 'logo',
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
