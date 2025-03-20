import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/journal_card.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Journal',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchJournals();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.CREATE_JOURNAL),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: border),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          foregroundColor: whiteColor,
                          radius: 16,
                          child: const Icon(
                            Iconsax.add,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Create Journal',
                          style: h6SemiBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Journal',
                    style: h5SemiBold,
                  ),
                  // Icon(
                  //   Icons.calendar_month,
                  //   color: primaryColor,
                  // ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Obx(() {
                  if (controller.journalList.isEmpty) {
                    return Center(
                      child: Text(
                        'No journals available',
                        style: h6SemiBold,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.journalList.length,
                    itemBuilder: (context, index) {
                      final journal = controller.journalList[index];
                      int emotionIndex =
                          controller.emotions.indexOf(journal['mood_level']);
                      Color emotionColor =
                          controller.emotionColors[emotionIndex];
                      DateTime date = DateTime.parse(journal['created_at']);
                      return JournalCard(
                        title: journal['title'],
                        body: journal['body'],
                        type: journal['mood_level'],
                        date: controller.formatDate(date),
                        typeColor: emotionColor,
                        getDelete: () async {
                          Get.defaultDialog(
                              backgroundColor: whiteColor,
                              title: 'Delete Journal',
                              middleText:
                                  'Are you sure you want to delete this journal?',
                              textCancel: 'Cancel',
                              textConfirm: 'Delete',
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                controller.deleteJournal(journal['journal_id']);
                                Get.back();
                                controller.fetchJournals();
                              },
                              onCancel: () => Get.back());
                        },
                        getEdit: () {
                          Get.toNamed(Routes.EDIT_JOURNAL, arguments: {
                            'id': journal['journal_id'],
                            'title': journal['title'],
                            'body': journal['body'],
                            'stress_level': journal['stress_level'],
                            'mood_level': journal['mood_level'],
                          });
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
