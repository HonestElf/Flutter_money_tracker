// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/utils/month_parser.dart';
import 'package:module_model/module_model.dart';
// import 'package:flutter_diplom_money_tracker/src/data/entities/cost_category.dart';

class CostsState {
  int chosenMonth;
  int chosenYear;

  final List<CostCategory> costCategories;

  String get monthName => parseMonth(chosenMonth);

  bool addCategoryWindowIsVisible;
  bool addCostWindowIsVisible;
  String? currentEditingCategory;

  List<CostCategory> get categoriesByMonth => costCategories.map((category) {
        return CostCategory(
            categoryName: category.categoryName,
            categoryColor: category.categoryColor,
            items: category.items.where((cost) {
              final parsedDate = DateTime.parse(cost.costDay);
              return parsedDate.month == chosenMonth &&
                  parsedDate.year == chosenYear;
            }).toList());
      }).toList();

  CostCategory get categoryByName {
    final category = costCategories.firstWhere(
        (element) => element.categoryName == currentEditingCategory);
    return CostCategory(
        categoryName: category.categoryName,
        categoryColor: category.categoryColor,
        items: category.items.where((cost) {
          final parsedDate = DateTime.parse(cost.costDay);
          return parsedDate.month == chosenMonth &&
              parsedDate.year == chosenYear;
        }).toList());
  }

  CostsState({
    this.costCategories = const [],
    this.chosenMonth = 0,
    this.chosenYear = 0,
    this.addCategoryWindowIsVisible = false,
    this.addCostWindowIsVisible = false,
    this.currentEditingCategory,
  });

  CostsState copyWith({
    int? chosenMonth,
    int? chosenYear,
    List<CostCategory>? costCategories,
    bool? addCategoryWindowIsVisible,
    bool? addCostWindowIsVisible,
    String? currentEditingCategory,
  }) {
    return CostsState(
        chosenMonth: chosenMonth ?? this.chosenMonth,
        chosenYear: chosenYear ?? this.chosenYear,
        costCategories: costCategories ?? this.costCategories,
        addCategoryWindowIsVisible:
            addCategoryWindowIsVisible ?? this.addCategoryWindowIsVisible,
        addCostWindowIsVisible:
            addCostWindowIsVisible ?? this.addCostWindowIsVisible,
        currentEditingCategory:
            currentEditingCategory ?? this.currentEditingCategory);
  }
}
