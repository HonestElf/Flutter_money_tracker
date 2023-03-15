import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/category_view.dart';

class CostCategoryCard extends StatelessWidget {
  const CostCategoryCard({super.key, required this.category});

  final CostCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 5)),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CategoryView(),
          ));
        },
        title: Text(category.categoryName),
        subtitle: const Text('Всего: 0'),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 40,
        ),
      ),
    );
  }
}
