// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/consult_data.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/history_calculate_duration.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consult_report_controller.dart';

class ConsultReportView extends GetView<ConsultReportController> {
  const ConsultReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final ConsultHistory data = Get.arguments as ConsultHistory;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Consultation Report",
          style: h3Bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          data.profileUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                  sbX12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.nama,
                            style: h4Bold, overflow: TextOverflow.ellipsis),
                        Text(data.expertise,
                            style: h6Regular, overflow: TextOverflow.ellipsis),
                        sby8,
                        Text(
                          calculateDuration(data.waktuMulai, data.waktuSelesai),
                          style: h7SemiBold,
                        ),
                        Text(
                          "${data.tanggal} | ${data.waktuMulai} - ${data.waktuSelesai}",
                          style: h7SemiBold,
                        ),
                        sby12,
                      ],
                    ),
                  ),
                ],
              ),
              sby12,
              Divider(),
              sby16,
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Description",
                    style: h7SemiBold.copyWith(
                      color: primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              sby16,
              Text(
                data.description ?? '-',
                style: h7Regular,
                textAlign: TextAlign.justify,
              ),
              sby16,
              Divider(),
              sby16,
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Summary",
                    style: h7SemiBold.copyWith(
                      color: primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              sby16,
              Text(
                data.summary!,
                style: h7Regular,
                textAlign: TextAlign.justify,
              ),
              sby16,
              Divider(),
              sby16,
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Task",
                    style: h7SemiBold.copyWith(
                      color: primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              sby16,
              Text(
                data.problem!,
                style: h7Regular,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
