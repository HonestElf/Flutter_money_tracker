import 'package:flutter_diplom_money_tracker/src/data/cost_item.dart';

class CostCategory {
  final String categoryName;
  final String categoryColor;
  List<CostItem> items = [];

  CostCategory(
      {required this.categoryName,
      required this.categoryColor,
      this.items = const []});
}
