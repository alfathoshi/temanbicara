import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/schedule/counselor_card.dart';
import '../controllers/consult_history_controller.dart';

class ConsultHistoryView extends GetView<ConsultHistoryController> {
  const ConsultHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Consultation History',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final List listData = snapshot.data!['data'];
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Get.to(
                        //   ConsultScheduleView(),
                        //   arguments: {
                        //     'user_name': listData[index]['user_name'],
                        //     'schedules': listData[index]['schedules'],
                        //     'expertise': listData[index]['expertise'],
                        //   },
                        // );
                      },
                      child: CounselorCard(
                          username: listData[index]['user_name'],
                          expertise: listData[index]['expertise'],
                          schedule: listData[index]['schedules']),
                    );
                  });
            } else {
              return Center(child: Text("Tidak Ada Data"));
            }
          }),
    );
  }
}
