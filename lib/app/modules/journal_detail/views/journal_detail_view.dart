import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/journal_detail_controller.dart';

class JournalDetailView extends GetView<JournalDetailController> {
  const JournalDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JournalDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
