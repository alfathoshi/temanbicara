import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class KualitasTidur extends StatelessWidget {
  final Color textColor;
  final Color BackgroundColor;
  final String Image;
  final String kualitas;
  final String waktu;

  const KualitasTidur({
    super.key,
    required this.Image,
    required this.kualitas,
    required this.waktu,
    required this.textColor,
    required this.BackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid, color: const Color(0xFF7D944D)),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(1, 1),
            )
          ],
          color: BackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kualitas,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    waktu,
                    style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/${Image}.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
