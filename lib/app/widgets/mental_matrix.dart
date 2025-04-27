import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class MentalMatrix extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final Icon icon;
  final String title;
  final String detail;
  final String image;
  const MentalMatrix({
    super.key,
    required this.color,
    required this.detail,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: border,
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        height: 83,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black26),
                  color: iconColor,
                ),
                child: Image.asset(
                  image,
                  scale: 1.5,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Mental Matrix", style: h7Regular,),
                    Text(
                      title,
                      style: h6SemiBold,
                    ),
                    Text(
                      detail,
                      style: h6Regular,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
