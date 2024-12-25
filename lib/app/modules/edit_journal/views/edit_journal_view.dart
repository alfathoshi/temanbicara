import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/wide_button.dart';
import '../controllers/edit_journal_controller.dart';

class EditJournalView extends GetView<EditJournalController> {
  const EditJournalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
            color: border,
          ),
        ),
        title: Text(
          'Edit Journal',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Journal Title',
              style: h6SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.document),
                hintText: 'Add Your Story...',
                hintStyle: h7RegularShade,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: border)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Write Your Entry',
              style: h6SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: TextField(
                controller: controller.bodyController,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.text,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Add Your Story...',
                  hintStyle: h7RegularShade,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: border)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Stress Level',
              style: h6SemiBold,
            ),
            Obx(
              () => Column(
                children: [
                  Slider(
                    value: controller.sliderValue.value,
                    divisions: 4,
                    min: 0,
                    max: 4,
                    onChanged: (value) {
                      controller.sliderValue.value = value;
                    },
                    activeColor: primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        Text(
                          i.toString(),
                          style: h6SemiBold,
                        ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Select Your Emotions',
              style: h6SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                5,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleEmotion(index);
                    },
                    child: Obx(
                      () => Opacity(
                        opacity: controller.getOpacity(index),
                        child: Image.asset(
                          'assets/images/emosi${index + 1}.png',
                          scale: 10,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Center(
                child: WideButton(
                  get: () {
                    controller.updateJournal();
                    Get.back(result: {
                      'id': controller.journalId,
                      'title': controller.titleController.text,
                      'body': controller.bodyController.text,
                      'stress_level': controller.sliderValue.value + 1,
                      'mood_level': controller.selectedEmotion.value,
                    });
                  },
                  color: primaryColor,
                  text: 'Edit Journal',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
