import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_item.dart';

class CostCard extends StatelessWidget {
  const CostCard({super.key, required this.item});

  final CostItem item;

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
        onTap: () {},
        title: Text(item.costPrice.toString()),
        subtitle: Text(item.costDay),
      ),
    );
  }
}
