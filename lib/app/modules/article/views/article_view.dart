import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  ArticleView({super.key});
  final List article = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Article',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 20,
              bottom: 20,
            ),
            child: Text(
              'Recommendation',
              style: h5Bold,
            ),
          ),
        ),
        article.isEmpty
            ? SliverToBoxAdapter(
                child: Center(
                child: Text('Tidak ada artikel', style: h6Regular,),
              ))
            : SliverList.builder(
                itemCount: article.length,
                itemBuilder: (context, index) {
                  print('Index bertipe String: ${article}');
                  return Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: TopArticle(
                      judul: article[index]["title"],
                      deskripsi: article[index]["content"],
                      author: article[index]["user"]["name"],
                      image: article[index]["image"],
                    ),
                  );
                })
      ]),
    );
  }
}
