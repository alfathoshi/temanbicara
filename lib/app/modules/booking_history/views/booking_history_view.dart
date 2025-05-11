import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/consult_complete_card.dart';
import 'package:temanbicara/app/widgets/consult/consult_pending_card.dart';
import '../controllers/booking_history_controller.dart';

class BookingHistoryView extends GetView<BookingHistoryController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: whiteColor,
          title: Text('Booking History', style: h3Bold),
          centerTitle: true,
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
            return TabBarView(
              children: [
                _buildList(controller.pendingList, true),
                _buildList(controller.completedList, false)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildList(RxList list, bool isPending) {
    if (list.isEmpty)
      return _buildEmptyState(isPending
          ? "No Pending Consultations"
          : "No Completed Consultations");

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: isPending
              ? ConsultPendingCard(consultPending: list[i])
              : ConsultCompleteCard(consultComplete: list[i]),
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
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Refresh',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          sby36,
        ],
      ),
    );
  }
}
