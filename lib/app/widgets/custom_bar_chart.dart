import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final List<dynamic> dummyData;
  final Color color;

  const CustomBarChart({
    super.key,
    required this.dummyData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, int> sleepValue = {
      "Insomnia": 1,
      "Kurang": 2,
      "Cukup": 3,
      "Baik": 4,
      "Nyenyak": 5
    };

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 150,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 20,
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
          ),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 24),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                interval: 1,
              ),
            ),
          ),
          maxY: 5,
          minY: 0,
          barGroups: dummyData
              .map(
                (data) => BarChartGroupData(
                  x: int.parse(data['created_at'].split("T")[0].split("-")[2]),
                  barRods: [
                    BarChartRodData(
                      toY: sleepValue[data['sleep_quality']]!.toDouble(),
                      color: color,
                      width: 23,
                      borderRadius: BorderRadius.circular(10),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

int findMax(List<dynamic> l) {
  int max = 0;
  for (var list in l) {
    if (list['sleep_hours'] > max) {
      max = list['sleep_hours'];
    }
  }
  return max;
}
