// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/data/consultComplete.dart';
import 'package:temanbicara/app/data/consultPending.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
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
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ConsultPendingCard(
                    consultPending: ConsultPending(
                        nama: "dummy, S.Psi.,M.Psi.",
                        durasi: "dummy",
                        tanggal: "dummy",
                        waktu: "dummy",
                        tanggalTenggat: "10 Apr",
                        waktuTenggat: "18:00",
                        metodePembayaran: "dummy",
                        totalHarga: "dummy"),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ConsultCompleteCard(
                    consultComplete: ConsultComplete(
                        nama: "dummy, S.Psi.,M.Psi.",
                        durasi: "dummy",
                        expertise: "dummy",
                        tanggal: "10 Apr",
                        waktu: "18:00"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
