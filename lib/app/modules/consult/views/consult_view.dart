// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/schedule/counselor_card.dart';
import 'package:temanbicara/app/widgets/schedule/filter_schedule_modal.dart';
import '../controllers/consult_controller.dart';

class ConsultView extends GetView<ConsultController> {
  ConsultView({super.key});
  @override
  final ConsultController controller = Get.put(ConsultController());

  @override
  Widget build(BuildContext context) {
    controller.clearExpertiseFilter();
    controller.fetchData();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text('Consultation', style: h3Bold),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: grey4Color, height: 0.5),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Filtered by: ${controller.selectedExpertise.join(', ')}",
                            style: h7SemiBold.copyWith(color: primaryColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.clearExpertiseFilter();
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
                              child: Text(
                                "Clear",
                                style: h7SemiBold.copyWith(color: error),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Filtered by: ${controller.selectedExpertise.join(', ')}",
                              style: h7SemiBold.copyWith(color: primaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.clearExpertiseFilter();
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
                                child: Text(
                                  "Clear",
                                  style: h7SemiBold.copyWith(color: error),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  sby16,
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // print(filteredData[index]['schedules']);
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
                            schedule: (filteredData[index]['schedules'] as List)
                                    .isNotEmpty
                                ? filteredData[index]['schedules'][0]['date']
                                : 'No schedule',
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
