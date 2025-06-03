// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/consult_data.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/buttons.dart';
import 'package:temanbicara/app/widgets/consult/format_full_date.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class ConsultHistoryCard extends StatelessWidget {
  final String nama;
  final String tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String counselorId;
  final String status;
  final String? problem;
  final String? summary;
  final String? description;

  ConsultHistoryCard({
    super.key,
    required this.nama,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.counselorId,
    required this.status,
    this.problem,
    this.summary,
    this.description,
  });

  final RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    final isDone = status == 'Done';

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            offset: const Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Hafid.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sbX12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama, style: h4Bold, overflow: TextOverflow.ellipsis),
                    sby12,
                    Text(
                      "$tanggal | $waktuMulai - $waktuSelesai",
                      style: h7Regular.copyWith(color: grey3Color),
                    ),
                    sby12,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isDone ? primaryColor : const Color(0xFF60ABEE),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isDone ? "Completed" : "Upcoming",
                        style: h7SemiBold.copyWith(
                          fontSize: 9,
                          color:
                              isDone ? primaryColor : const Color(0xFF60ABEE),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          sby12,
          Divider(),
          sby12,
          MyButtonCustom(
            get: () {
              print(tanggal + waktuMulai);
              print(tanggal + waktuSelesai);
              if (isDone) {
                ConsultHistory consultHistory = ConsultHistory(
                  nama: nama,
                  tanggal: tanggal,
                  waktuMulai: waktuMulai,
                  waktuSelesai: waktuSelesai,
                  counselorId: counselorId,
                  status: status,
                  problem: problem,
                  summary: summary,
                  description: description,
                  durasi: "$waktuMulai - $waktuSelesai",
                );
                Get.toNamed(
                  Routes.CONSULT_REPORT,
                  arguments: consultHistory,
                );
              } else {
                DateTime now = DateTime.now();
                DateTime startTime = parseDateWithMonthName(waktuMulai);
                DateTime endTime = parseDateWithMonthName(waktuSelesai);

                if (now.isAfter(startTime) && now.isBefore(endTime)) {
                  Get.toNamed(
                    Routes.CHAT_ROOM,
                    arguments: {
                      'name': nama,
                      'counselor_id': counselorId,
                    },
                  );
                } else {
                  CustomSnackbar.showSnackbar(
                    title: "Oops!",
                    message: "Only Available during Schedule",
                    status: false,
                  );
                }
              }
            },
            foreColor: whiteColor,
            backColor: primaryColor,
            text: isDone ? "View Report" : "Chat",
            height: 28,
            width: double.infinity,
            style: h6Bold.copyWith(color: whiteColor),
          )
        ],
      ),
    );
  }
}
