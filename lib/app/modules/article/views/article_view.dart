import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/top_article.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned:true,
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
        SliverList.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: TopArticle(
                  judul: data[index]["judul"],
                  deskripsi: data[index]["deskripsi"],
                  author: data[index]["author"],
                  image: data[index]["image"],
                ),
              );
            })
      ]),
    );
  }

  List<Map<String, dynamic>> data = [
    {
      "image": "article1",
      "judul": "What is mental health?",
      "deskripsi":
          "Mental health is about how people think, feel, and behave. Mental health care professionals can help people manage conditions such as depression, anxiety, bipolar disorder, addiction, and other disorders that affect their thoughts, feelings, and behaviors,Mental health can affect a person’s day-to-day life, relationships, and physical health. External factors in people’s lives and relationships can also contribute to their mental well-being.Looking after one’s mental health can help a person maintain their ability to enjoy life. This involves balancing their activities, responsibilities, and efforts to achieve psychological resilience.Stress, depression, and anxiety can affect mental health and may disrupt a person’s routine.Although healthcare professionals often use the term “mental health,” doctors recognize that many mental health conditions have physical roots.This article explains what mental health and mental health conditions mean. It also describes the most common types of mental health disorders, including their early signs and how to treat them.",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    },
    {
      "image": "article1",
      "judul": "a",
      "deskripsi": "loremipsum",
      "author": "gina cantik"
    }
  ];
}
