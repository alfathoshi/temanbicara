// ignore_for_file: prefer_const_constructors

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
          title: Text(
            'Booking History',
            style: h3Bold,
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: grey2Color,
            labelStyle: h4SemiBold,
            unselectedLabelStyle: h4SemiBold,
            indicatorColor: primaryColor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () => controller.fetchData(),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            return TabBarView(
              children: [
                _buildPendingTab(),
                _buildCompletedTab(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPendingTab() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: controller.pendingList.isEmpty
          ? _buildEmptyState('No Pending Consultations')
          : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.pendingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: ConsultPendingCard(
                    consultPending: controller.pendingList[index],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCompletedTab() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: controller.completedList.isEmpty
          ? _buildEmptyState('No Completed Consultations')
          : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.completedList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: ConsultCompleteCard(
                    consultComplete: controller.completedList[index],
                  ),
                );
              },
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
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => controller.fetchData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Refresh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          sby36,
        ],
      ),
    );
  }
}
