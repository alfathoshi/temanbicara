// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class CounselorCard extends StatelessWidget {
  final String username;
  final String expertise;
  final List schedule;
  const CounselorCard(
      {super.key,
      required this.username,
      required this.expertise,
      required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 131,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(9, 30, 66, 0.25),
                blurRadius: 8,
                spreadRadius: -2,
                offset: Offset(
                  0,
                  4,
                ),
              ),
              BoxShadow(
                color: Color.fromRGBO(9, 30, 66, 0.08),
                blurRadius: 0,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  0,
                ),
              ),
            ],
            color: whiteColor,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/Hafid.jpg',
                  scale: 1.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${username}',
                      style: h6Bold.copyWith(overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Expertise : ${expertise}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
