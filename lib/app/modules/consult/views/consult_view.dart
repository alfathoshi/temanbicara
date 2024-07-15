import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/consult_controller.dart';

class ConsultView extends GetView<ConsultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConsultView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConsultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
