// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/ui/cost_category_card/cost_category_card.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_category_modal.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_cost_modal.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';

  void _openDateModal(BuildContext context) async {
    final chosenDate = await showMonthPicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (chosenDate != null && context.mounted) {
      context.read<CostsBloc>().add(ChangeDate(date: chosenDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CostsBloc, CostsState>(
        listener: (context, state) {
          if (state.addCategoryWindowIsVisible) {
            var costsBloc = context.read<CostsBloc>();

            showDialog(
              context: context,
              builder: (_) => BlocProvider(
                  create: (_) => AddCubit(costsBloc: costsBloc),
                  child: const AddCategoryModal()),
            );
          } else if (state.addCostWindowIsVisible) {
            var costsBloc = context.read<CostsBloc>();
            final categoryName = state.currentEditingCategory;

            showDialog(
              context: context,
              builder: (_) => BlocProvider(
                  create: (_) => AddCubit(costsBloc: costsBloc),
                  child: AddCostModal(
                    currentEditingCategory: categoryName!,
                  )),
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: TextButton(
              onPressed: () {
                _openDateModal(context);
              },
              child: Text(
                state.monthName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<CostsBloc>().add(OpenAddCategoryModal());
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Column(
            children: const [
              Expanded(
                flex: 3,
                child: CostsPieChart(),
              ),
              Expanded(
                flex: 5,
                child: CostsCategories(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CostsPieChart extends StatelessWidget {
  const CostsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        bool isEmpty = true;
        for (var element in state.categoriesByMonth) {
          if (element.items.isNotEmpty) {
            isEmpty = false;
            break;
          } else {
            isEmpty = true;
          }
        }

        return isEmpty
            ? const Center(
                child: Text('Пока нет трат'),
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                color: Colors.grey[200],
                child: PieChart(
                  PieChartData(
                    sections: [
                      ...state.categoriesByMonth.map((category) {
                        double costsSum = 0;
                        for (var element in category.items) {
                          costsSum += element.costPrice.toDouble();
                        }
                        return PieChartSectionData(
                            value: costsSum,
                            radius: 70,
                            color: getColorFromHex(category.categoryColor));
                      })
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class CostsCategories extends StatelessWidget {
  const CostsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.categoriesByMonth.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 25,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context.read<CostsBloc>().add(SetCurrentEditingCategory(
                  categoryName: state.costCategories[index].categoryName));
              context.read<CostsBloc>().add(OpenAddCostModal());
            },
            child: CostCategoryCard(
              category: state.categoriesByMonth[index],
            ),
          ),
          padding: const EdgeInsets.all(25),
        );
      },
    );
  }
}
