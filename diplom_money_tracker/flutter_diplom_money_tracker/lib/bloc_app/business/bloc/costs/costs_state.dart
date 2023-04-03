import 'package:flutter_diplom_money_tracker/bloc_app/business/utils/month_parser.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/entities/cost_category.dart';

class CostsState {
  late int chosenMonth;
  late int chosenYear;

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

  CostsState({
    this.costCategories = const [],
    this.chosenMonth = 0,
    this.chosenYear = 0,
    this.addCategoryWindowIsVisible = false,
    this.addCostWindowIsVisible = false,
    this.currentEditingCategory,
  }) {
    chosenMonth = DateTime.now().month;
    chosenYear = DateTime.now().year;
  }

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
