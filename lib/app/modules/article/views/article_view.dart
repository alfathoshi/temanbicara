import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../../../widgets/custom_appbar.dart';
import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Article",
          style: h3Bold,
        ),
      ),
      backgroundColor: whiteColor,
      body: Obx(() {
        if (controller.isLoadingInitial.value && controller.articles.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }
        return RefreshIndicator(
          onRefresh: controller.refreshArticles,
          color: primaryColor,
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
                  child: Text('Recommendation', style: h5Bold),
                ),
              ),
              if (controller.articles.isEmpty &&
                  !controller.isLoadingInitial.value)
                SliverToBoxAdapter(
                    child: Center(
                        child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text('Tidak ada artikel tersedia saat ini.',
                      style: h6Regular),
                )))
              else
                SliverList.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final articleItem = controller.articles[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: TopArticle(
                        judul: articleItem["title"],
                        deskripsi: articleItem["content"],
                        author: articleItem["user"]?["name"],
                        image: articleItem["image"] ?? 'logo',
                        date: articleItem['created_at'] ?? '',
                      ),
                    );
                  },
                ),
              if (controller.isLoadingMore.value)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: CircularProgressIndicator(color: primaryColor)),
                  ),
                ),
              if (!controller.hasMoreData.value &&
                  controller.articles.isNotEmpty &&
                  !controller.isLoadingInitial.value)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                        child: Text("All articles are displayed",
                            style: h7Regular.copyWith(color: greyColor))),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
