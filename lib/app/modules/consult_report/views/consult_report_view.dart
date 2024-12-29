// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/spaces.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consult_report_controller.dart';

class ConsultReportView extends GetView<ConsultReportController> {
  const ConsultReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Consultation History',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 130,
                  width: 100,
                  child: Image.asset('assets/images/Hafid.jpg'),
                ),
                sbX12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama'),
                    Text('Date'),
                    Text('Time'),
                    Text('Problem'),
                  ],
                ),
              ],
            ),
            sby36,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 6,
                    spreadRadius: -1,
                    offset: Offset(
                      0,
                      4,
                    ),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    blurRadius: 4,
                    spreadRadius: -1,
                    offset: Offset(
                      0,
                      2,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consultation result :',
                      style: h4Bold,
                    ),
                    Divider(),
                    SizedBox(height: 5),
                    Text('Description', style: h5Medium),
                    Text('Description', style: h6Medium),
                    Divider(),
                    Text('Summary', style: h5Medium),
                    Text('Summary', style: h6Medium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
