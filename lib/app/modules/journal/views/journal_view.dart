// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/journal_card.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/journal_shimmer.dart';
import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  JournalView({super.key});
  @override
  final JournalController controller = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Journal",
          style: h3Bold,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.CREATE_JOURNAL),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: border),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      foregroundColor: whiteColor,
                      radius: 16,
                      child: const Icon(Iconsax.add, size: 16),
                    ),
                    sbX24,
                    Text('Create Journal', style: h6SemiBold),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: primaryColor,
              backgroundColor: whiteColor,
              onRefresh: () => controller.fetchJournals(),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.journalList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildJournalCardShimmer();
                    },
                  );
                }

                final journals = controller.journalList;

                if (journals.isEmpty) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: Get.height * 0.5,
                        child: Center(
                          child: Text('No journals today', style: h6SemiBold),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: journals.length,
                  itemBuilder: (context, index) {
                    final journal = journals[index];
                    DateTime date = DateTime.parse(journal['created_at']);
                    return JournalCard(
                      title: journal['title'],
                      body: journal['body'],
                      date: formatDate(date),
                      image: journal['image_url'] ?? '',
                      getDelete: () {/* kode delete */},
                      getJournal: () {/* kode open detail */},
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
