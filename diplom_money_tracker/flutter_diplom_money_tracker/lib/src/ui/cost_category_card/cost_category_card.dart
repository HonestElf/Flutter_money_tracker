// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/bloc/costs/costs_bloc.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/costs/costs_events.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/costs/costs_state.dart';
import 'package:flutter_diplom_money_tracker/src/business/utils/color_parser.dart';
import 'package:flutter_diplom_money_tracker/src/data/entities/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/ui/details_view/details_view.dart';

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
  @override
  Widget build(BuildContext context) {
    double costsSum = 0;

    for (var element in widget.category.items) {
      costsSum += element.costPrice.toDouble();
    }
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        return Dismissible(
          key: Key(
              '${widget.category.categoryName}_${widget.category.categoryColor}'),
          onDismissed: (direction) {
            context.read<CostsBloc>().add(
                DeleteCategory(categoryName: widget.category.categoryName));
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
              title: Text(widget.category.categoryName),
              subtitle: Text('Всего: $costsSum'),
              trailing: IconButton(
                onPressed: () {
                  context.read<CostsBloc>().add(SetCurrentEditingCategory(
                      categoryName: widget.category.categoryName));

                  Navigator.of(context).pushNamed(DetailsView.routeName);
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
      },
    );
  }
}
