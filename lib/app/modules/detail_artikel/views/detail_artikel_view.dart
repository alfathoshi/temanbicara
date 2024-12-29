import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/top_article.dart';
import '../controllers/detail_artikel_controller.dart';

class DetailArtikelView extends GetView<DetailArtikelController> {
  final String? image;
  final String? judul;
  final String? deskripsi;
  final String? author;

  DetailArtikelView(
      {this.image, this.judul, this.deskripsi, this.author, super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/${image}.png',
                height: 221,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              judul!,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            Icon(Icons.share)
                          ],
                        ),
                        Row(
                          children: [
                            Text(author!,
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF9C9C9C))),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 350,
                              child: Text(
                                deskripsi!,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                        sby12,
                        Container(
                        
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(3, (index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.only(left: 24, right: 24),
                                    child: TopArticle(
                                        judul: judul!,
                                        deskripsi: deskripsi!,
                                        author: author!,
                                        image: image!));
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
