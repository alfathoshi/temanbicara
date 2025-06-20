import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/assesment_2_controller.dart';

class Assesment2View extends GetView<Assesment2Controller> {
  Assesment2View({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        height: 87,
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {"indexPage": 0});
          },
          child: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          scale: 4,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey there, glad you’re here',
                        style: h3Bold,
                      ),
                      sby16,
                      Text(
                        'This is your personal check-in space. Log your thoughts, moods, or habits daily to build a better understanding of yourself',
                        style: h5Medium,
                      ),
                      sby32,
                      Image.asset('assets/images/meditation.png'),
                      const Expanded(
                          child:
                              SizedBox()), // ini bakal dorong konten terakhir ke bawah
                      Center(
                        child: Text(
                          ' Ready to start your journey?',
                          style: h6Bold,
                        ),
                      ),
                      sby12,
                      MyButton(
                        get: () {
                          Get.toNamed(Routes.NEW_TRACKING);
                        },
                        color: primaryColor,
                        text: 'Tracking',
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
