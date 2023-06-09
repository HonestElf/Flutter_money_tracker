// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';

class CostCard extends StatelessWidget {
  const CostCard({super.key, required this.item, required this.categoryName});

  final CostItem item;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        return Dismissible(
          key: Key('${item.costDay}_${item.costPrice}'),
          onDismissed: (direction) {
            context
                .read<CostsBloc>()
                .add(DeleteCost(categoryName: categoryName, item: item));
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
              title: Text(item.costPrice.toString()),
              subtitle: Text(item.costDay),
            ),
          ),
        );
      },
    );
  }
}
