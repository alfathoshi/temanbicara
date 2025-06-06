// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:temanbicara/app/data/booking_complete.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';
import 'package:temanbicara/app/widgets/transaction/idr_formatter.dart';

class BookingDetails extends StatelessWidget {
  final BookingComplete bookingComplete;
  const BookingDetails({super.key, required this.bookingComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Booking Details",
          style: h3Bold,
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Complete",
                    style: h4Bold,
                  ),
                  sby12,
                  Divider(
                    thickness: 0.5,
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Invoice", style: h6SemiBold),
                      Text(
                        bookingComplete.invoice,
                        style: h6Regular,
                      )
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Booking Date", style: h6SemiBold),
                      Text(bookingComplete.bookingDate, style: h6Regular)
                    ],
                  ),
                  sby36,
                  Text(
                    "Counselor Details",
                    style: h4Bold,
                  ),
                  sby12,
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            bookingComplete.profileUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      sbX12,
                      Column(
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
                              Text("Expertise: "),
                              Text(
                                bookingComplete.transaction.expertise,
                                style: h7Regular.copyWith(
                                  color: grey2Color,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  sby36,
                  Text(
                    "Consultation Information",
                    style: h4Bold,
                  ),
                  sby16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Topic", style: h6SemiBold),
                      Text("Consultation", style: h6Regular)
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Consultation Method", style: h6SemiBold),
                      Text(bookingComplete.transaction.metode, style: h6Regular)
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Duration", style: h6SemiBold),
                      Text(bookingComplete.transaction.durasi, style: h6Regular)
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Session", style: h6SemiBold),
                      Text(bookingComplete.transaction.sesi.toString(),
                          style: h6Regular)
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Schedule", style: h6SemiBold),
                      Text(bookingComplete.transaction.jadwal, style: h6Regular)
                    ],
                  ),
                  sby12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time", style: h6SemiBold),
                      Text(bookingComplete.transaction.waktu, style: h6Regular)
                    ],
                  ),
                ],
              ),
            ),
            sby24,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: grey4Color,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sby8,
                    Text(
                      "Transaction Details",
                      style: h4Bold,
                    ),
                    sby16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: h6SemiBold,
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              bookingComplete.transaction.harga, 2),
                          style: h6Regular,
                        )
                      ],
                    ),
                    sby8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Consultation Price",
                          style: h6SemiBold,
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              bookingComplete.transaction.harga, 2),
                          style: h6Regular,
                        )
                      ],
                    ),
                    sby8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Application Tax.",
                          style: h6SemiBold,
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              bookingComplete.transaction.appTax, 2),
                          style: h6Regular,
                        )
                      ],
                    ),
                    sby8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Administration Tax.",
                          style: h6SemiBold,
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                              bookingComplete.transaction.admTax, 2),
                          style: h6Regular,
                        )
                      ],
                    ),
                    sby16,
                    Divider(
                      thickness: 0.5,
                    ),
                    sby16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: h6SemiBold,
                        ),
                        Text(
                          CurrencyFormat.convertToIdr(
                            bookingComplete.transaction.harga + 15000 + 1000,
                            2,
                          ),
                          style: h6SemiBold,
                        )
                      ],
                    ),
                    sby12,
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
