// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/Transaction.dart';
import 'package:temanbicara/app/modules/transaction/views/transaction_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/schedule/schedule_details.dart';

import '../controllers/consult_schedule_controller.dart';

class ConsultScheduleView extends GetView<ConsultScheduleController> {
  const ConsultScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final userName = arguments['user_name'];
    final schedules = arguments['schedules'];
    final expertise = arguments['expertise'];

    Map<String, dynamic> selectedSchedule = {};

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
          'Schedules',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22),
                Container(
                  height: 127,
                  width: double.infinity,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/Hafid.jpg',
                          scale: 1.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userName}',
                                style: h6Bold.copyWith(
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        blurRadius: 6,
                                        spreadRadius: -1,
                                        offset: Offset(
                                          0,
                                          4,
                                        ),
                                      ),
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.06),
                                        blurRadius: 4,
                                        spreadRadius: -1,
                                        offset: Offset(
                                          0,
                                          2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Expertise :',
                                          style: h7Bold,
                                        ),
                                        SizedBox(height: 5),
                                        Text(expertise,
                                            style:
                                                h6Medium.copyWith(fontSize: 10))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  "Schedule",
                  style: h3Bold,
                ),
                SizedBox(height: 20),
                ScheduleList(
                  schedule: schedules,
                  onSelectionChanged: (selected) {
                    selectedSchedule = selected;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 205,
                    height: 42,
                    child: ElevatedButton(
                      child: Text(
                        'Booking Now',
                        style: h5Bold.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        if (selectedSchedule.isNotEmpty) {
                          print(selectedSchedule['time']);
                          Get.to(
                            () => TransactionView(),
                            arguments: TransactionModel(
                              namaPsikiater: userName,
                              expertise: expertise,
                              jadwal: selectedSchedule['date']!,
                              waktu: selectedSchedule['time']!,
                              selectedID: selectedSchedule['id'],
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "Silahkan pilih jadwal konsultasi",
                            "Please select a date and time before proceeding.",
                            backgroundColor: primaryColor.withOpacity(0.6),
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
