import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CostsPieChart extends StatefulWidget {
  const CostsPieChart({super.key});

  @override
  State<CostsPieChart> createState() => _CostsPieChartState();
}

class _CostsPieChartState extends State<CostsPieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: PieChart(PieChartData(
          borderData: FlBorderData(
              border: Border.all(color: Colors.red, width: 10), show: true),
          sections: [
            PieChartSectionData(value: 40, radius: 70),
            PieChartSectionData(value: 40, radius: 70),
            PieChartSectionData(value: 20, radius: 70)
          ])),
    );
  }
}
