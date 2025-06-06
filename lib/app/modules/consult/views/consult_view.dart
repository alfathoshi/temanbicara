// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/schedule/counselor_card.dart';
import 'package:temanbicara/app/widgets/schedule/filter_schedule_bar.dart';
import 'package:temanbicara/app/widgets/schedule/filter_schedule_modal.dart';
import '../controllers/consult_controller.dart';

class ConsultView extends GetView<ConsultController> {
  ConsultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Consultation",
          style: h3Bold,
        ),
      ),
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: controller.fetchData,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          } else if (controller.schedules.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterBarWidget(
                  selectedFilters: controller.selectedExpertise,
                  onClear: controller.clearExpertiseFilter,
                ),
                Spacer(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset("assets/images/transaksi-gagal.png"),
                      ),
                      sby16,
                      Text(
                        "Oops! It looks like all slots are full.",
                        style: h5Bold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            );
          } else {
            final selectedFilters = controller.selectedExpertise
                .map((e) => e.toLowerCase())
                .toList();

            final List filteredData =
                controller.schedules['data'].where((counselor) {
              final hasSchedule = (counselor['schedules'] as List).isNotEmpty;
              if (selectedFilters.isEmpty) return hasSchedule;

              final raw = (counselor['expertise'] as List?)?.first ?? '';
              final expertiseList = raw
                  .toString()
                  .split('|')
                  .map((e) => e.trim().toLowerCase())
                  .toList();

              return hasSchedule &&
                  expertiseList.any((item) => selectedFilters.contains(item));
            }).toList();

            if (filteredData.isEmpty) {
              final filter = controller.selectedExpertise;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterBarWidget(
                    selectedFilters: controller.selectedExpertise,
                    onClear: controller.clearExpertiseFilter,
                  ),
                  Spacer(),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child:
                              Image.asset("assets/images/transaksi-gagal.png"),
                        ),
                        sby16,
                        Text(
                          filter.isEmpty
                              ? "Oops! It looks like all slots are full."
                              : "No counselor found for \"${filter.join(', ')}\".",
                          style: h5Bold,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Choose Counselor",
                            style: h5Bold.copyWith(color: black)),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24)),
                              ),
                              builder: (context) => FilterBottomSheet(),
                            );
                          },
                          child: Container(
                            width: 69,
                            height: 23,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: grey4Color),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text("Filter",
                                  style:
                                      h7SemiBold.copyWith(color: primaryColor)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  sby8,
                  if (controller.selectedExpertise.isNotEmpty)
                    FilterBarWidget(
                      selectedFilters: controller.selectedExpertise,
                      onClear: controller.clearExpertiseFilter,
                    ),
                  sby16,
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final schedules =
                            filteredData[index]['schedules'] as List;
                        int totalSchedules = 0;

                        for (var item in schedules) {
                          final schedulesByDate =
                              item['schedulesByDate'] as List;
                          totalSchedules += schedulesByDate.length;
                        }
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
                                ((filteredData[index]['expertise'] as List?)
                                            ?.first ??
                                        '')
                                    .toString()
                                    .split('|')
                                    .map((e) => e.trim())
                                    .join(', '),
                            schedule: totalSchedules.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
