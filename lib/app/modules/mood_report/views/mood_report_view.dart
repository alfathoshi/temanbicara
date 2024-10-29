import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mood_report_controller.dart';

class MoodReportView extends GetView<MoodReportController> {
  const MoodReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodReportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoodReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
