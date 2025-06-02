// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/modules/detail_artikel/views/detail_artikel_view.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';

class TopArticle extends StatelessWidget {
  final String? judul;
  final String? deskripsi;
  final String? author;
  final String? image;
  final String? date;
  const TopArticle({
    super.key,
    this.judul,
    this.deskripsi,
    this.author,
    this.image,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    String displayDate = "Tanggal tidak tersedia";
    if (date != null && date!.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(date!);
        displayDate = DateFormat('dd MMMM yyyy').format(parsedDate);
      } catch (e) {
        print("Error parsing date in TopArticle ('$date'): $e");
        displayDate = date!;
      }
    }

    bool isNetworkImage =
        image != null && image != 'logo' && image!.startsWith('http');

    return InkWell(
      onTap: () {
        Get.to(
          DetailArtikelView(
            image: image,
            judul: judul,
            deskripsi: deskripsi,
            author: author,
            date: formatDate(DateTime.parse(date!)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          height: 149,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.1)),
                  ),
                  child: Image.asset(
                    'assets/images/$image.png',
                    scale: 4,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 17, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        judul ?? "No Title",
                        style: h6Bold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      sby5,
                      Text(
                        deskripsi ?? "No Description",
                        style: h7Regular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      sby24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            author ?? "Unknown Author",
                            style: h6Medium,
                          ),
                          Text(
                            displayDate,
                            style: h7Regular,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
