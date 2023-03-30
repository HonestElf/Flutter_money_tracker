import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/entities/cost_category.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/cost_category_card/cost_category_card.dart';

final List<CostCategory> categories = [
  CostCategory(categoryName: 'Cat', categoryColor: 'F2B846'),
  CostCategory(categoryName: 'Home', categoryColor: '46B4F2'),
  CostCategory(categoryName: 'Other', categoryColor: '9053EB')
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Home view'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _costsPieChart(),
          ),
          Expanded(
            flex: 5,
            child: _costsCategories(),
          ),
        ],
      ),
    ));
  }

  Widget _costsPieChart() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, radius: 70, color: Colors.green),
            PieChartSectionData(value: 20, radius: 70, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _costsCategories() {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 25,
      ),
      itemBuilder: (context, index) => CostCategoryCard(
        category: categories[index],
      ),
      padding: const EdgeInsets.all(25),
    );
  }
}
