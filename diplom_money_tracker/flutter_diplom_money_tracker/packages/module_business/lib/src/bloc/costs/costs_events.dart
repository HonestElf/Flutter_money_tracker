// Package imports:
import 'package:module_model/module_model.dart';

abstract class CostsEvent {}

class LoadAllCategories extends CostsEvent {
  List<CostCategory> categories;

  LoadAllCategories({required this.categories});
}

class ChangeDate extends CostsEvent {
  final DateTime date;

  ChangeDate({required this.date});
}

class OpenAddCategoryModal extends CostsEvent {}

class CloseAddCategoryModal extends CostsEvent {}

class OpenAddCostModal extends CostsEvent {}

class CloseAddCostModal extends CostsEvent {}

class SetCurrentEditingCategory extends CostsEvent {
  final String categoryName;

  SetCurrentEditingCategory({required this.categoryName});
}

class AddNewCategory extends CostsEvent {
  final String categoryName;
  final String categoryColor;

  AddNewCategory({required this.categoryName, required this.categoryColor});
}

class AddNewCost extends CostsEvent {
  final String categoryName;
  final String date;
  final num price;

  AddNewCost(
      {required this.categoryName, required this.date, required this.price});
}

class DeleteCategory extends CostsEvent {
  final String categoryName;

  DeleteCategory({required this.categoryName});
}

class DeleteCost extends CostsEvent {
  final String categoryName;
  final CostItem item;

  DeleteCost({required this.categoryName, required this.item});
}
