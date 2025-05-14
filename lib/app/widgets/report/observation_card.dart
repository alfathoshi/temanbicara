import 'package:flutter/material.dart';

import '../../themes/colors.dart';
import '../../themes/fonts.dart';
import '../../themes/spaces.dart';

class ObservationCard extends StatelessWidget {
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final String iconAsset;
  final double iconScale;
  final String title;
  final String? value;
  final String description;
  final String? indicatorAsset;
  final Widget? indicatorText;
  final double scale;

  const ObservationCard({
    super.key,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconAsset,
    required this.iconScale,
    required this.title,
    required this.value,
    required this.description,
    required this.scale,
    this.indicatorAsset,
    this.indicatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: border, blurRadius: 2, offset: const Offset(0, 2))
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: iconBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(iconAsset, scale: iconScale),
                  ),
                ),
                sbX12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: h4SemiBold),
                      Text(value ?? 'Loading...', style: h5Regular),
                    ],
                  ),
                ),
                indicatorAsset != null
                    ? Image.asset(indicatorAsset!, scale: scale)
                    : (indicatorText ?? const SizedBox()),
              ],
            ),
            sby16,
            Text(description, style: h5Regular),
          ],
        ),
      ),
    );
  }
}
