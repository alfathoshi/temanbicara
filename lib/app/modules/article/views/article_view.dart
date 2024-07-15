import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArticleView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ArticleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
