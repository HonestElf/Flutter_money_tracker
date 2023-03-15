import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_item.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/cost_card.dart';

final List<CostItem> items = [
  CostItem(costPrice: 30, costDay: '30/12/2012'),
  CostItem(costPrice: 23.4, costDay: '30/10/2000')
];

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            itemBuilder: (context, index) => CostCard(item: items[index]),
            padding: const EdgeInsets.all(25),
          )),
    );
  }
}
