import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    super.key,
    required this.dummyData,
  });

  final List dummyData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 150,
      decoration: BoxDecoration(),
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
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 24),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                interval: findMax(dummyData).toDouble() / 4,
              ),
            ),
          ),
          maxY: findMax(dummyData).toDouble(),
          minY: 0,
          barGroups: dummyData
              .map(
                (data) => BarChartGroupData(
                  x: int.parse(data['date']),
                  barRods: [
                    BarChartRodData(
                      toY: data['sleep_hours'].toDouble(),
                      color: const Color(0xFFFEBE58),
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
