import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/journal_detail_controller.dart';

class JournalDetailView extends GetView<JournalDetailController> {
  const JournalDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
            color: border,
          ),
        ),
        title: Column(
          children: [
            Text(
              'Detail Journal',
              style: h3Bold,
            ),
            Text(
              controller.displayDate.value,
              style: h6Regular,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Journal Title',
                style: h6SemiBold,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: greyColor),
                  color: whiteColor,
                ),
                child: Text(
                  controller.title.value,
                  style: h5Regular.copyWith(color: black),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Entry',
                style: h6SemiBold,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: greyColor),
                  color: whiteColor,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    controller.body.value,
                    style: h5Regular.copyWith(color: black),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Uploaded Image',
                style: h6SemiBold,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: greyColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9.0),
                  child: Image.network(
                    controller.imageUrl.value,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return  Center(child: CircularProgressIndicator(color: primaryColor));
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.gallery_slash,
                                size: 40, color: grey2Color),
                            SizedBox(height: 8),
                            Text('Image not available',
                                style: TextStyle(color: grey2Color)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ),
      ),
    );
  }
}
