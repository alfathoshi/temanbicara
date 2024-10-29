import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tracking_2_controller.dart';

class Tracking2View extends GetView<Tracking2Controller> {
  const Tracking2View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking2View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Tracking2View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
