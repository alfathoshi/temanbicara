// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
      child: Container(
        width: double.infinity,
        height: 131,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            color: Color(0xFFEEEEEE).withOpacity(0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 16, 0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                  border: Border.all(color: whiteColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: Offset(2, 2),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  height: 110,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.network(
                      bookingComplete.profileUrl,
                      width: double.infinity,
                      height: 223,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              sbX12,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      ],
                    ),
                    sby5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.clock,
                              size: 12,
                            ),
                            sbx5,
                            Text(
                              bookingComplete.transaction.durasi,
                              style: h7SemiBold,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar_2,
                              size: 12,
                            ),
                            sbx5,
                            Text(
                              '${bookingComplete.transaction.waktu},',
                              style: h7SemiBold,
                            ),
                            sbx5,
                            Text(
                              bookingComplete.transaction.jadwal,
                              style: h7SemiBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
