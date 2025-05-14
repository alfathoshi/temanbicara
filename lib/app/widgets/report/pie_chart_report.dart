import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../themes/fonts.dart';

class PieChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> categories;
  final Map<String, int> dataCounts;
  final List<Color> chartColors;
  final int touchedIndex;
  final ValueChanged<int> onTouch;
  final Widget? centerWidget;

  const PieChartCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.categories,
    required this.dataCounts,
    required this.chartColors,
    required this.touchedIndex,
    required this.onTouch,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final total = dataCounts.values.fold(0, (a, b) => a + b);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 2)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: h4SemiBold),
            Text(subtitle, style: h6Regular),
            AspectRatio(
              aspectRatio: 1.2,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          if (!event.isInterestedForInteractions ||
                              response?.touchedSection == null) {
                            onTouch(-1);
                            return;
                          }
                          onTouch(
                              response!.touchedSection!.touchedSectionIndex);
                        },
                      ),
                      sections: List.generate(categories.length, (i) {
                        final category = categories[i];
                        final count = dataCounts[category] ?? 0;
                        final value = total > 0 ? (count / total) * 100 : 0;
                        final isTouched = touchedIndex == i;

                        return PieChartSectionData(
                          color: chartColors[i],
                          value: value.toDouble(),
                          title:
                              isTouched ? '${value.toStringAsFixed(1)}%' : '',
                          radius: isTouched ? 55 : 50,
                          titleStyle: h6SemiBold,
                        );
                      }),
                      centerSpaceRadius: 50,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                  if (centerWidget != null) Center(child: centerWidget!),
                ],
              ),
            ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: List.generate(categories.length, (i) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: chartColors[i],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(categories[i], style: h6Regular),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
