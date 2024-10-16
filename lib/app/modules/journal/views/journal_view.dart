import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/journal_card.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 85,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                side: BorderSide(color: Colors.black12)),
            title: Text(
              'Journal',
              style: h3Bold,
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
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
                          borderRadius: BorderRadius.circular(10)),
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
                            )
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
                      Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return JournalCard();
              })
        ],
      ),
    );
  }
}
