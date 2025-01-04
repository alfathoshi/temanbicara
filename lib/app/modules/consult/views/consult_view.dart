// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/consult_schedule/views/consult_schedule_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/schedule/counselor_card.dart';
import '../controllers/consult_controller.dart';

class ConsultView extends GetView<ConsultController> {
  ConsultView({Key? key}) : super(key: key);

  final ConsultController controller = Get.put(ConsultController());

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
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Consult',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
    onRefresh: controller.fetchData,
    child: Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.schedules.isEmpty) {
        return Center(
          child: Text("No Data Available"),
        );
      } else {
        final List listData = controller.schedules['data'];
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: listData.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.CONSULT_SCHEDULE,
                  arguments: {
                    'user_name': listData[index]['name'],
                    'schedules': listData[index]['schedules'],
                    'expertise': listData[index]['expertise'],
                  },
                );
              },
              child: CounselorCard(
                username: listData[index]['name'],
                expertise: listData[index]['expertise'],
                schedule: listData[index]['schedules'],
              ),
            );
          },
        );
      }
    }),
  ),
    );
  }
}
