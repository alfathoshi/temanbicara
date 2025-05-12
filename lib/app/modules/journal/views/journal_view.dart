import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/journal_card.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/date.dart';
import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  JournalView({super.key});
  @override
  final JournalController controller = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Journal',
          style: h3Bold,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: grey4Color,
            height: 0.5,
          ),
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
                  GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value,
                          firstDate: DateTime(2000, 01, 01),
                          lastDate: DateTime.now(),
                          confirmText: "Select",
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: primaryColor,
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          if (!isSameDate(
                              pickedDate, controller.selectedDate.value)) {
                            controller.updateDate(pickedDate);
                            controller.fetchJournals();
                          }
                        }
                      },
                      child: const Icon(Icons.calendar_month_outlined)),
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
                      DateTime date = DateTime.parse(journal['created_at']);
                      return JournalCard(
                        title: journal['title'],
                        body: journal['body'],
                        date: controller.formatDate(date),
                        image: journal['image_url'] ?? '',
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
