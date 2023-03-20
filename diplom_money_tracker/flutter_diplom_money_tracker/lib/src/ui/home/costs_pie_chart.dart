import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/ui/utils/color_parser.dart';

class CostsPieChart extends StatefulWidget {
  const CostsPieChart({super.key, required this.categories});
  final List<CostCategory> categories;

  @override
  State<CostsPieChart> createState() => _CostsPieChartState();
}

class _CostsPieChartState extends State<CostsPieChart> {
  static const color = '#bfeb91';
  @override
  Widget build(BuildContext context) {
    return widget.categories.isEmpty
        ? const Center(
            child: Text('Пока нет трат'),
          )
        : Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            color: Colors.grey[200],
            child: PieChart(PieChartData(
                borderData: FlBorderData(
                    border: Border.all(color: Colors.red, width: 10),
                    show: true),
                sections: [
                  ...widget.categories.map((category) {
                    double costsSum = 0;

                    for (var element in category.items) {
                      costsSum += element.costPrice.toDouble();
                    }
                    return PieChartSectionData(
                        value: costsSum,
                        radius: 70,
                        color: getColorFromHex(color));
                  })
                ])),
          );
  }
}
