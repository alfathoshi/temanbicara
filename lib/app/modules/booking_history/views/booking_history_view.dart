// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/booking_complete_card.dart';
import 'package:temanbicara/app/widgets/consult/booking_pending_card.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import '../controllers/booking_history_controller.dart';

class BookingHistoryView extends GetView<BookingHistoryController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: CustomAppBar(
          title: Text(
            'Booking History',
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
          backgroundColor: whiteColor,
          onRefresh: controller.fetchData,
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }
            return TabBarView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                RefreshIndicator(
                    color: primaryColor,
                    backgroundColor: whiteColor,
                    onRefresh: controller.fetchData,
                    child: _buildList(controller.pendingList, true)),
                RefreshIndicator(
                    color: primaryColor,
                    backgroundColor: whiteColor,
                    onRefresh: controller.fetchData,
                    child: _buildList(controller.completedList, false))
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildList(RxList list, bool isPending) {
    if (list.isEmpty) {
      return _buildEmptyState(isPending
          ? "No Pending Consultations"
          : "No Completed Consultations");
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: isPending
              ? BookingPendingCard(bookingPending: list[i])
              : BookingCompleteCard(bookingComplete: list[i]),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 100),
      children: [
        SizedBox(
          height: Get.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/noBooking.png",
                scale: 1.5,
              ),
              sby24,
              Text(message, style: h4Bold),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
