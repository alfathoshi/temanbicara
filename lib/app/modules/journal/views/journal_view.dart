// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/date.dart';
import 'package:temanbicara/app/widgets/journal_card.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
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
                        sbX24,
                        Text(
                          'Create Journal',
                          style: h6SemiBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sby24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Journal',
                    style: h5SemiBold,
                  ),
                  Obx(
                    () => FlexibleDatePicker(
                      selectedDate: controller.selectedDate.value,
                      isIconOnly: true,
                      onDateChanged: (picked) {
                        controller.updateDate(picked);
                        controller.fetchJournals();
                      },
                    ),
                  ),
                ],
              ),
              sby16,
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.journalList.isEmpty) {
                    return Center(
                      child: Text(
                        'No journals todoy',
                        style: h6SemiBold,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.journalList.length,
                    itemBuilder: (context, index) {
                      final journal = controller.journalList[index];
                      DateTime date = DateTime.parse(journal['created_at']);
                      return JournalCard(
                        title: journal['title'],
                        body: journal['body'],
                        date: formatDate(date),
                        image: journal['image_url'] ?? '',
                        getDelete: () async {
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: Get.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: whiteColor,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.warning, color: error, size: 48),
                                    sby16,
                                    Text(
                                      'Delete Journal',
                                      style: h4Bold,
                                    ),
                                    sby12,
                                    Text(
                                      'Are you sure you want to delete this journal?',
                                      textAlign: TextAlign.center,
                                      style: h6Regular,
                                    ),
                                    sby24,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            'Cancel',
                                            style: h6Regular,
                                          ),
                                        ),
                                        sbx8,
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: error,
                                          ),
                                          onPressed: () {
                                            controller.deleteJournal(
                                                journal['journal_id']);
                                            Get.back();
                                            controller.fetchJournals();
                                          },
                                          child: Text(
                                            'Delete',
                                            style: h6Regular.copyWith(
                                                color: whiteColor),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            barrierDismissible: false,
                          );
                        },
                        getJournal: () {
                          Get.toNamed(Routes.JOURNAL_DETAIL, arguments: {
                            'journal_id': journal['journal_id'],
                            'title': journal['title'],
                            'body': journal['body'],
                            'image_url': journal['image_url'],
                            'created_at': journal['created_at'],
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
