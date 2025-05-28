import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../controllers/detail_artikel_controller.dart';

class DetailArtikelView extends GetView<DetailArtikelController> {
  final String? image;
  final String? judul;
  final String? deskripsi;
  final String? author;
  // final DateTime date;

  const DetailArtikelView({
    // this.date,
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
                child: Image.asset(
                  'assets/images/$image.png',
                  height: 221,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    judul ?? "No Title",
                    softWrap: true,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              author ?? "Unknown Author",
              style: h6SemiBold,
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
            sby12,
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Text('data')
                      // TopArticle(
                      //     judul: judul ?? "No Title",
                      //     deskripsi: deskripsi ?? "No Description",
                      //     author: author ?? "Unknown Author",
                      //     image: image ?? "default_image",
                      //     date: date),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
