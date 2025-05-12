import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(87),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                24, MediaQuery.of(context).padding.top + 24, 24, 24),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 25,
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
          ),
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
