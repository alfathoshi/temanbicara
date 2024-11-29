import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/detail_artikel/views/detail_artikel_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TopArticle extends StatelessWidget {
  final String? image;
  final String? judul;
  final String? deskripsi;
  final String? author;
  const TopArticle(
      {super.key,
    this.judul,
    this.deskripsi,
    this.author,this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>DetailArtikelView(image: image,judul: judul,deskripsi: deskripsi,author: author,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: 326,
          height: 149,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(
              color: border,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image.asset(
                      'assets/images/${image}.png',
                      scale: 4,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 17, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      judul!,
                      style: h6Bold,
                    ),
                    Container(
                     width: 150,
                      child: Text(
                        deskripsi!,
                        style: h7Regular,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      author!,
                      style: h6Medium,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
