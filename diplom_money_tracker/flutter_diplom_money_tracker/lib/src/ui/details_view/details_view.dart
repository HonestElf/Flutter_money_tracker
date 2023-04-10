// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/ui/cost_card/cost_card.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  static const routeName = 'detailsView';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        final category = state.categoryByName;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                style:
                    TextStyle(color: getColorFromHex(category.categoryColor)),
                category.categoryName,
              ),
              backgroundColor: const Color(0xFF9053EB),
            ),
            body: ListView.separated(
              itemCount: category.items.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              itemBuilder: (context, index) => CostCard(
                  item: category.items[index],
                  categoryName: category.categoryName),
              padding: const EdgeInsets.all(25),
            ),
          ),
        );
      },
    );
  }
}
