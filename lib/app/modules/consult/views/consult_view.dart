// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/schedule/counselor_card.dart';
import '../controllers/consult_controller.dart';

class ConsultView extends GetView<ConsultController> {
  ConsultView({Key? key}) : super(key: key);

  @override
  final ConsultController controller = Get.put(ConsultController());

  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Consultation',
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
        onRefresh: controller.fetchData,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.schedules.isEmpty) {
            return Center(child: Text("No Data Available"));
          } else {
            final List filteredData = controller.schedules['data']
                .where(
                    (counselor) => (counselor['schedules'] as List).isNotEmpty)
                .toList();

            if (filteredData.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      "assets/images/transaksi-gagal.png",
                    ),
                  ),
                  sby16,
                  Text(
                    "Oops! It looks like all slots are full.",
                    style: h5Bold,
                  ),
                ],
              ));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.CONSULT_SCHEDULE,
                      arguments: {
                        'user_name': filteredData[index]['name'],
                        'schedules': filteredData[index]['schedules'],
                        'expertise': filteredData[index]['expertise'],
                      },
                    );
                  },
                  child: CounselorCard(
                    username: filteredData[index]['name'],
                    expertise:
                        (filteredData[index]['expertise'] as List).join(', '),
                    schedule:
                        (filteredData[index]['schedules'] as List).isNotEmpty
                            ? filteredData[index]['schedules'][0]['date']
                            : 'No schedule',
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
