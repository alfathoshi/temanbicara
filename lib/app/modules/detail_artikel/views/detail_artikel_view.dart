// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../../../widgets/top_article.dart';
import '../controllers/detail_artikel_controller.dart';

class DetailArtikelView extends GetView<DetailArtikelController> {
  final String? image;
  final String? judul;
  final String? deskripsi;
  final String? author;
  final String? date;

  const DetailArtikelView({
    this.date,
    this.image,
    this.judul,
    this.deskripsi,
    this.author,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Text(
          "Article",
          style: h3Bold,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (image != null && image!.isNotEmpty)
              Center(
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(judul ?? "No Title",
                      softWrap: true, maxLines: 3, style: h4Bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  author ?? "Unknown Author",
                  style: h6SemiBold,
                ),
                Text(
                  date ?? "Date",
                  style: h5Regular,
                )
              ],
            ),
            sby24,
            SizedBox(
              width: double.infinity,
              child: Text(
                deskripsi ?? "No Description Available",
                overflow: TextOverflow.fade,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
