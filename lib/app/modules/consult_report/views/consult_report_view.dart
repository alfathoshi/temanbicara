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
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12),
          ),
          title: Text(
            'Consultation Report',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: controller.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final List consultations = snapshot.data!['data'];

                if (consultations.isEmpty) {
                  return Center(child: Text("No consultations found."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: consultations.length,
                  itemBuilder: (context, index) {
                    final consultation = consultations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 130,
                                width: 100,
                                child: Image.asset('assets/images/Hafid.jpg'),
                              ),
                              sbX12,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      consultation['general_user_name'] ?? '-',
                                      style: h4Bold,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    consultation['date'] ?? '-',
                                    style: h6Medium,
                                  ),
                                  Text(
                                    '${consultation['start_time']} - ${consultation['end_time']}',
                                    style: h6Medium,
                                  ),
                                  Text(
                                    consultation['problem'] ?? '-',
                                    style: h5Medium,
                                  ),
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
                                  offset: Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.06),
                                  blurRadius: 4,
                                  spreadRadius: -1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Consultation result:',
                                    style: h4Bold,
                                  ),
                                  Divider(),
                                  SizedBox(height: 5),
                                  Text('Description', style: h5Medium),
                                  Text(
                                    consultation['description'] ?? '-',
                                    style: h6Medium,
                                  ),
                                  Divider(),
                                  Text('Summary', style: h5Medium),
                                  Text(
                                    consultation['summary'] ?? '-',
                                    style: h6Medium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("Failed to load consultations."));
              }
            },
          ),
        ));
  }
}
