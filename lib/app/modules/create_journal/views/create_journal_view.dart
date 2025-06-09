import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/wide_button.dart';
import '../../../widgets/loading_overlay.dart';
import '../controllers/create_journal_controller.dart';

class CreateJournalView extends GetView<CreateJournalController> {
  const CreateJournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: Text(
          "Journal",
          style: h3Bold,
        ),
      ),
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
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
                    cursorColor: black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.document),
                      hintText: 'Add your stroy...',
                      hintStyle: h5Regular.copyWith(color: grey2Color),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColor),
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
                      cursorColor: black,
                      decoration: InputDecoration(
                        hintText: 'Write your day here...',
                        hintStyle: h5Regular.copyWith(color: grey2Color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greyColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: MyButton(
                      get: () async {
                        bool isSuccess = await controller.submitJournal();
                        if (isSuccess) {
                          Get.offAllNamed(Routes.NAVIGATION_BAR,
                              arguments: {"indexPage": 1});
                        }
                      },
                      color: primaryColor,
                      text: 'Create Journal',
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => LoadingOverlay(
                isLoading: controller.isLoading.value,
              ))
        ],
      ),
    );
  }
}
