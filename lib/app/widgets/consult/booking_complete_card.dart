// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/data/booking_complete.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/consult/booking_details.dart';

class BookingCompleteCard extends StatelessWidget {
  final BookingComplete bookingComplete;
  const BookingCompleteCard({
    super.key,
    required this.bookingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BookingDetails(
          bookingComplete: bookingComplete,
        ));
      },
      child: Padding(
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
                      bookingComplete.transaction.namaPsikiater,
                      style: h4Bold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    sby5,
                    Text(
                      bookingComplete.transaction.expertise,
                      style: h7Regular.copyWith(
                        color: grey2Color,
                      ),
                    ),
                    sby5,
                    Text(
                      bookingComplete.transaction.durasi,
                      style: h7SemiBold,
                    ),
                    Row(
                      children: [
                        Text(
                          bookingComplete.transaction.jadwal,
                          style: h7SemiBold,
                        ),
                        sbx5,
                        Text(
                          bookingComplete.transaction.waktu,
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
      ),
    );
  }
}
