import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_state.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/utils/color_parser.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/cost_card/cost_card.dart';

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
            appBar: _appBar(),
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

  PreferredSize _appBar() {
    final appBarheight = AppBar().preferredSize.height;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarheight),
      child: BlocBuilder<CostsBloc, CostsState>(
        builder: (context, state) {
          final category = context.read<CostsBloc>().state.categoryByName;
          return AppBar(
            centerTitle: true,
            title: Text(
              style: TextStyle(color: getColorFromHex(category.categoryColor)),
              category.categoryName,
            ),
            backgroundColor: const Color(0xFF9053EB),
          );
        },
      ),
    );
  }
}
