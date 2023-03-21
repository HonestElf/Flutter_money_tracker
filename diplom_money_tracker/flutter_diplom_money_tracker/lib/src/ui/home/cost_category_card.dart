import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/firestore_api.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/category_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_cost_modal.dart';
import 'package:flutter_diplom_money_tracker/src/ui/utils/color_parser.dart';

class CostCategoryCard extends StatefulWidget {
  const CostCategoryCard({super.key, required this.category});
  final CostCategory category;

  @override
  State<CostCategoryCard> createState() => _CostCategoryCardState();
}

class _CostCategoryCardState extends State<CostCategoryCard> {
  void openModalWindow() {
    showDialog(
      context: context,
      builder: (context) {
        return AddCostModal(positiveCallback: addCostCallback);
      },
    );
  }

  void deleteCategoryItem() {
    deleteCategory(widget.category.categoryName);
  }

  void addCostCallback(
    num price,
    String date,
  ) {
    addCost(widget.category.categoryName, price, date);
  }

  @override
  Widget build(BuildContext context) {
    double costsSum = 0;

    for (var element in widget.category.items) {
      costsSum += element.costPrice.toDouble();
    }
    return Dismissible(
      key: Key(
          '${widget.category.categoryName}_${widget.category.categoryColor}'),
      onDismissed: (direction) {
        deleteCategoryItem();
      },
      background: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.red,
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Удалить',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      child: Container(
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
          onTap: openModalWindow,
          title: Text(widget.category.categoryName),
          subtitle: Text('Всего: $costsSum'),
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(CategoryView.routeName, arguments: {
                'categoryName': widget.category.categoryName,
                'categoryColor': widget.category.categoryColor
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_right_outlined,
              color: getColorFromHex(widget.category.categoryColor),
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
