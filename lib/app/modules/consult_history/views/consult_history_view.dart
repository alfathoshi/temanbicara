// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/consult_history_card.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consult_history_controller.dart';
import '../../../data/consult_data.dart';

class ConsultHistoryView extends GetView<ConsultHistoryController> {
  const ConsultHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar(
          title: Text(
            'Consultation History',
            style: h3Bold,
          ),
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: grey2Color,
            labelStyle: h4SemiBold,
            indicatorColor: primaryColor,
            indicatorWeight: 3,
            tabs: const [Tab(text: 'Pending'), Tab(text: 'Completed')],
          ),
        ),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: controller.fetchData,
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final pendingList = controller.consultList
                .where((e) => e.status == 'Incoming')
                .toList();
            final completedList = controller.consultList
                .where((e) => e.status == 'Done')
                .toList();

            return TabBarView(
              children: [
                _buildList(pendingList),
                _buildList(completedList),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/noBooking.png"),
          sby24,
          Text(message, style: h4Bold),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.fetchData,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Refresh',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          sby36,
        ],
      ),
    );
  }

  Widget _buildList(List<ConsultHistory> list) {
    if (list.isEmpty) {
      return _buildEmptyState("No Consultations Found");
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, i) {
          final item = list[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ConsultHistoryCard(
              nama: item.nama,
              tanggal: item.tanggal,
              waktuMulai: item.waktuMulai,
              waktuSelesai: item.waktuSelesai,
              counselorId: item.counselorId,
              status: item.status,
              problem: item.problem,
              summary: item.summary,
              description: item.description,
            ),
          );
        },
      ),
    );
  }
}
