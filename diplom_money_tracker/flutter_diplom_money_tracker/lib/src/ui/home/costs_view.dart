import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/cost_category_card.dart';

final List<CostCategory> categories = [
  CostCategory(categoryName: 'Cat', categoryColor: 'F2B846'),
  CostCategory(categoryName: 'Home', categoryColor: '46B4F2'),
  CostCategory(categoryName: 'Other', categoryColor: '9053EB')
];

class CostsView extends StatefulWidget {
  final List<CostCategory> categories;
  const CostsView({super.key, required this.categories});

  @override
  State<CostsView> createState() => _CostsViewState();
}

class _CostsViewState extends State<CostsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.categories.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 25,
      ),
      itemBuilder: (context, index) =>
          CostCategoryCard(category: widget.categories[index]),
      padding: const EdgeInsets.all(25),
    );
  }
}
