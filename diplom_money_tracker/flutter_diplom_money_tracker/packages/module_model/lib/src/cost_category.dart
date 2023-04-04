// Project imports:
import 'package:module_model/src/cost_item.dart';

class CostCategory {
  final String categoryName;
  final String categoryColor;
  List<CostItem> items = [];

  CostCategory(
      {required this.categoryName,
      required this.categoryColor,
      this.items = const []});

  factory CostCategory.fromJson(Map<String, Object?> json) => CostCategory(
        categoryName: json['name'] as String,
        categoryColor: json['color'] as String,
        items: json['costs'] != null
            ? [
                ...(json['costs'] as List<dynamic>)
                    .map((item) => CostItem.fromJson(item))
              ]
            : [],
      );

  Map<String, Object?> toJson() => {
        'name': categoryName,
        'color': categoryColor,
        'costs': items.map((e) => e.toJson())
      };
}
