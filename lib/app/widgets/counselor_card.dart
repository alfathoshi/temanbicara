import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/history_chatbot.dart';

class CounselorCard extends StatelessWidget {
  const CounselorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 131,
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Image.asset(
                'assets/images/profile.png',
                scale: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama',
                    style: h6SemiBold,
                  ),
                  Text(
                    'Expertise',
                    style: h7Regular,
                  ),
                  Text(
                    'Detail',
                    style: h7Regular,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: 75,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.chevron_right,
                    color: whiteColor,
                    size: 36,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
