// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
        child: Padding(
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
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
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
                              style: h7SemiBold.copyWith(color: primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sby8,
              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.schedules.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 14,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                final selectedFilters = controller.selectedExpertise
                    .map((e) => e.toLowerCase())
                    .toList();

                final List filteredData =
                    controller.schedules['data'].where((counselor) {
                  final hasSchedule =
                      (counselor['schedules'] as List).isNotEmpty;
                  if (selectedFilters.isEmpty) return hasSchedule;

                  final expertiseList =
                      (counselor['expertise'] as List<dynamic>)
                          .map((e) => e.toString().toLowerCase())
                          .toList();

                  return hasSchedule &&
                      expertiseList
                          .any((item) => selectedFilters.contains(item));
                }).toList();

                if (controller.schedules.isEmpty || filteredData.isEmpty) {
                  final filter = controller.selectedExpertise;
                  return Expanded(
                    child: Column(
                      children: [
                        if (filter.isNotEmpty)
                          FilterBarWidget(
                            selectedFilters: controller.selectedExpertise,
                            onClear: controller.clearExpertiseFilter,
                          ),
                        const Spacer(),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                    "assets/images/transaksi-gagal.png"),
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
                        const Spacer(),
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                // print(filteredData[index]['profile_url']);
                                Get.toNamed(
                                  Routes.CONSULT_SCHEDULE,
                                  arguments: {
                                    'user_name': filteredData[index]['name'],
                                    'schedules': filteredData[index]
                                        ['schedules'],
                                    'image': filteredData[index]['profile_url'],
                                    'expertise': filteredData[index]
                                        ['expertise'],
                                  },
                                );
                              },
                              child: CounselorCard(
                                username: filteredData[index]['name'],
                                expertise: (filteredData[index]['expertise']
                                        as List<dynamic>)
                                    .join(', '),
                                schedule: totalSchedules.toString(),
                                image: filteredData[index]['profile_url'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
