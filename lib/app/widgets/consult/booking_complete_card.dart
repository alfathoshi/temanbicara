// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/booking_complete.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';

class BookingCompleteCard extends StatelessWidget {
  final BookingComplete bookingComplete;
  const BookingCompleteCard({
    super.key,
    required this.bookingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: grey4Color,
          ),
        ),
        height: 140,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 26, 16, 20),
          child: Row(
            children: [
              Container(
                width: 68,
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Hafid.jpg',
                    scale: 1.5,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              sbX12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookingComplete.nama,
                    style: h4Bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  sby5,
                  Text(
                    bookingComplete.expertise,
                    style: h7Regular.copyWith(
                      color: grey2Color,
                    ),
                  ),
                  sby5,
                  Text(
                    bookingComplete.durasi,
                    style: h7SemiBold,
                  ),
                  Row(
                    children: [
                      Text(
                        bookingComplete.tanggal,
                        style: h7SemiBold,
                      ),
                      sbx5,
                      Text(
                        bookingComplete.waktu,
                        style: h7SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
