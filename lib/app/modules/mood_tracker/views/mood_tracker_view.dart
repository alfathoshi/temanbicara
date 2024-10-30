import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mood_tracker_controller.dart';

class MoodTrackerView extends GetView<MoodTrackerController> {
  const MoodTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodTrackerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoodTrackerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
