import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../themes/spaces.dart';
import '../../../widgets/wide_button.dart';
import '../controllers/edit_journal_controller.dart';

class EditJournalView extends GetView<EditJournalController> {
  const EditJournalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Text(
          "Edit Journal",
          style: h3Bold,
        ),
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
            sby16,
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
            sby16,
            Text(
              'Write Your Entry',
              style: h6SemiBold,
            ),
            sby16,
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
            sby16,
            Text(
              'Upload Image',
              style: h6SemiBold,
            ),
            const SizedBox(height: 8),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: controller.pickedImage.value != null
                      ? Image.file(controller.pickedImage.value!,
                          fit: BoxFit.cover)
                      : const Center(
                          child: Icon(Icons.add_a_photo,
                              size: 40, color: grey2Color)),
                ),
              );
            }),
            sby16,
            Expanded(
              child: Center(
                child: WideButton(
                  get: () {
                    controller.updateJournal();
                    Get.back(result: {
                      'id': controller.journalId,
                      'title': controller.titleController.text,
                      'body': controller.bodyController.text,
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
