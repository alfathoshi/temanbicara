import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temanbicara/app/modules/profile/controllers/profile_controller.dart';
import 'package:temanbicara/app/modules/report/controllers/report_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';
import 'package:temanbicara/app/widgets/mental_matrix.dart';
import 'package:temanbicara/app/widgets/my_journal.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../../../widgets/journal_shimmer.dart';
import '../../journal/controllers/journal_controller.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  GetStorage box = GetStorage();
  HomeView({super.key});
  final ReportController reportController = Get.find<ReportController>();
  final JournalController journalController = Get.find<JournalController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () async {
          await Future.wait([
            controller.fetchData(),
            journalController.fetchJournals(),
            reportController.checkTracking(),
            profileController.fetchData()
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
                        Obx(
                          () {
                            if (profileController.isLoading.value) {
                              return Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 21),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 120,
                                            height: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 90,
                                            height: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: border,
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: whiteColor,
                                      backgroundImage: NetworkImage(
                                          profileController.profileUrl.value),
                                    ),
                                  ),
                                  const SizedBox(width: 21),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hello, ${box.read('name')}',
                                          style: h3SemiBold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'How\'s your day?',
                                          style: h4Regular,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                          },
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
                          () {
                            if (controller.isLoading.value) {
                              return _buildMentalMatrixShimmer(context);
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  if (reportController.isTrackingFilled.value) {
                                    Get.toNamed(Routes.REPORT);
                                  } else {
                                    Get.toNamed(Routes.NEW_TRACKING);
                                  }
                                },
                                child: MentalMatrix(
                                  color: lightGreen,
                                  icon: const Icon(Icons.edit),
                                  image: 'assets/images/limiter.png',
                                  title: reportController.title.value.isNotEmpty
                                      ? reportController.title.value
                                      : '',
                                  detail:
                                      reportController.detail.value.isNotEmpty
                                          ? reportController.detail.value
                                          : "You haven’t tracked yet today!",
                                  matrixValue:
                                      reportController.isTrackingFilled.value
                                          ? reportController.matrixValue.value
                                          : '',
                                  isFilled:
                                      reportController.isTrackingFilled.value,
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
                                  sby8,
                                  Text(
                                    'Talk about your problems \nwith a professional psychologist',
                                    style: h6Regular,
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
                                    child: Obx(() => Text(
                                          controller.randomShortTermGoal.value
                                                  .isNotEmpty
                                              ? controller
                                                  .randomShortTermGoal.value
                                              : '“Loading your goal...”',
                                          style: h6Regular,
                                          textAlign: TextAlign.center,
                                        )),
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
                            return buildJournalCardShimmer();
                          } else if (journalController.journalList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "No journals today",
                                  style: h6Medium,
                                ),
                              ),
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
                                    date: formatDate(date),
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
                              'Latest articles',
                              style: h4SemiBold,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final data = controller.articles;
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
                  if (controller.isLoading.value) {
                    return _buildTopArticleShimmer();
                  } else if (controller.articles['status'] == false) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "No articles published",
                          style: h6Medium,
                        ),
                      ),
                    );
                  } else {
                    final List articles =
                        (controller.articles.containsKey('data') &&
                                controller.articles['data'] is Map &&
                                controller.articles['data'].containsKey('data'))
                            ? controller.articles['data']['data'] ?? []
                            : [];

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
                              judul: articles[index]["title"] ?? 'asd',
                              deskripsi: articles[index]["content"] ?? '',
                              author: articles[index]["user"]["name"] ?? '',
                              image: articles[index]["image_url"] ?? 'logo',
                              date: articles[index]['created_at'] ?? '',
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

Widget _buildTopArticleShimmer() {
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: border,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              sbX12,
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 18.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    sby8,
                    Container(
                      width: double.infinity,
                      height: 14.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    sby5,
                    Container(
                      width: double.infinity,
                      height: 14.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    sby5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 12.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                        Container(
                          width: 20,
                          height: 12.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildMentalMatrixShimmer(BuildContext context) {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: border,
            width: 1,
          ),
        ),
        height: 83,
        width: MediaQuery.sizeOf(context).width,
      ),
    ),
  );
}
