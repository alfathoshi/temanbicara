import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/data/transaction_model.dart';
import 'package:temanbicara/app/modules/transaction/views/transaction_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/consult/history_calculate_duration.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
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

    // ignore: unused_local_variable
    DateTime selectedDate = DateTime.now();
    // ignore: unused_local_variable
    Map<String, dynamic> selectedSchedule = {};
    final consultController = Get.put(ConsultScheduleController());

    bool hasScheduleForSelectedDate(DateTime date) {
      final dateOnly = DateFormat('yyyy-MM-dd').format(date);
      return schedules.any((element) {
        final scheduleDateRaw = element['date'];
        final parsedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(scheduleDateRaw));
        return parsedDate == dateOnly;
      });
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Schedule",
          style: h3Bold,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
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
                      style: h5Bold.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: const Color(0xFF7D8A95),
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
                                  CustomSnackbar.showSnackbar(
                                    title: "Oops!",
                                    message: "Mind Choosing a Schedule?",
                                    status: false,
                                  );
                                  return;
                                }

                                String durationStr = selected['time'];
                                List<String> times = durationStr.split(' - ');

                                String start = times[0];
                                String end = times[1];
                                print(calculateDuration(start, end));

                                Get.dialog(
                                  Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor)),
                                  barrierDismissible: false,
                                );

                                await Future.delayed(
                                    const Duration(seconds: 2));
                                Get.back();

                                Get.to(
                                  () => const TransactionView(),
                                  arguments: TransactionModel(
                                    durasi: calculateDuration(start, end),
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
                          : const SizedBox.shrink();
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
