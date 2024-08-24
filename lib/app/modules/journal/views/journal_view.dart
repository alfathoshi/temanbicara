import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JournalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'JournalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
