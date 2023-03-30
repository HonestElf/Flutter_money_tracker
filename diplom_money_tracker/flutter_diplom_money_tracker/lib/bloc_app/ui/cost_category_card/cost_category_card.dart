import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/entities/cost_category.dart';

class CostCategoryCard extends StatefulWidget {
  const CostCategoryCard({
    super.key,
    required this.category,
  });
  final CostCategory category;
  // final Function navigateCallback;

  @override
  State<CostCategoryCard> createState() => _CostCategoryCardState();
}

class _CostCategoryCardState extends State<CostCategoryCard> {
  // void openModalWindow() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AddCostModal(positiveCallback: addCostCallback);
  //     },
  //   );
  // }

  // void deleteCategoryItem() {
  //   deleteCategory(widget.category.categoryName);
  // }

  // void addCostCallback(
  //   num price,
  //   String date,
  // ) {
  //   addCost(widget.category.categoryName, price, date);
  // }

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
        // deleteCategoryItem();
      },
      background: Container(
        padding: const EdgeInsets.all(8),
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
          // onTap: openModalWindow,
          title: Text(widget.category.categoryName),
          subtitle: Text('Всего: $costsSum'),
          trailing: IconButton(
            onPressed: () {
              // widget.navigateCallback(
              // widget.category.categoryName, widget.category.categoryColor);
              // Navigator.of(context)
              //     .pushNamed(CategoryView.routeName, arguments: {
              //   'categoryName': widget.category.categoryName,
              //   'categoryColor': widget.category.categoryColor
              // });
            },
            icon: Icon(
              Icons.keyboard_arrow_right_outlined,
              // color: getColorFromHex(widget.category.categoryColor),

              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
