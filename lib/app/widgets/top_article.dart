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
    String displayDate = "Date is not available";
    if (date != null && date!.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(date!);
        displayDate = DateFormat('dd MMMM yyyy').format(parsedDate);
      } catch (e) {
        print("Error parsing date in TopArticle ('$date'): $e");
        displayDate = date!;
      }
    }

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
          height: 140,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: border, width: 1),
                  ),
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
