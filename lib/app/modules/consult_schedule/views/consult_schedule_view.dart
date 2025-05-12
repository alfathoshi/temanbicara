// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction/views/transaction_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/schedule/schedule_details.dart';
import 'package:temanbicara/app/widgets/schedule/select_date.dart';

import '../controllers/consult_schedule_controller.dart';

class ConsultScheduleView extends GetView<ConsultScheduleController> {
  const ConsultScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final userName = arguments['user_name'];
    final schedules = arguments['schedules'];
    final expertiseList = arguments['expertise'];
    final expertise = (expertiseList as List).join(", ");

    DateTime selectedDate = DateTime.now();
    Map<String, dynamic> selectedSchedule = {};
    final consultController = Get.put(ConsultScheduleController());

    bool hasScheduleForSelectedDate(DateTime date) {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      return schedules.any((element) => element['date'] == dateStr);
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Schedule',
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Image.asset(
                  "assets/images/Hafid.jpg",
                  width: double.infinity,
                  height: 223,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sby24,
                    Text(
                      '$userName',
                      style: h2Bold.copyWith(overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    sby8,
                    Text(
                      expertise,
                      style: h3Bold.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF7D8A95),
                      ),
                      maxLines: 2,
                    ),
                    sby48,
                    Text(
                      "Select Date",
                      style: h3Bold,
                    ),
                    sby24,
                    SelectDate(
                      onDateSelected: (date) {
                        selectedDate = date;
                        consultController.updateSelectedDate(date);
                      },
                    ),
                    sby24,
                    Text(
                      "Schedules",
                      style: h3Bold,
                    ),
                    sby24,
                    ScheduleList(
                      schedule: schedules,
                      selectedDate: consultController.selectedDate,
                    ),
                    sby36,
                    Obx(() {
                      final date = consultController.selectedDate.value;
                      final hasSchedule = hasScheduleForSelectedDate(date);

                      return hasSchedule
                          ? MyButton(
                              get: () async {
                                final selected =
                                    consultController.selectedSchedule.value;

                                if (selected.isEmpty ||
                                    selected['date'] == null ||
                                    selected['time'] == null) {
                                  Get.snackbar(
                                    "Silahkan pilih jadwal konsultasi",
                                    "Please select a date and time before proceeding.",
                                    backgroundColor: error.withOpacity(0.6),
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                Get.dialog(
                                  Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor)),
                                  barrierDismissible: false,
                                );

                                await Future.delayed(Duration(seconds: 2));
                                Get.back();

                                Get.to(
                                  () => TransactionView(),
                                  arguments: TransactionModel(
                                    namaPsikiater: userName,
                                    expertise: expertise,
                                    jadwal: selected['date'],
                                    waktu: selected['time'],
                                    selectedID: selected['id'],
                                  ),
                                );
                              },
                              color: primaryColor,
                              text: "Booking Now",
                            )
                          : SizedBox.shrink();
                    }),
                    sby36,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
