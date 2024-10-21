import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/assesment_2_controller.dart';

class Assesment2View extends GetView<Assesment2Controller> {
  const Assesment2View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assesment2View'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Assesment2View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
