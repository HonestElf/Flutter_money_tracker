import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_bloc,.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_events.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_state.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/category_add_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/entities/cost_category.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/cost_category_card/cost_category_card.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/modals/add_category_modal.dart';

final List<CostCategory> categories = [
  CostCategory(categoryName: 'Cat', categoryColor: 'F2B846'),
  CostCategory(categoryName: 'Home', categoryColor: '46B4F2'),
  CostCategory(categoryName: 'Other', categoryColor: '9053EB')
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<CostsBloc, CostsState>(
      listener: (context, state) {
        if (state.addCategoryWindowIsVisible) {
          var costsBloc = context.read<CostsBloc>();

          showDialog(
            context: context,
            builder: (_) => BlocProvider(
                create: (_) => CategoryAddCubit(costsBloc: costsBloc),
                child: const AddCategoryModal()),
          );
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: _costsPieChart(),
            ),
            Expanded(
              flex: 5,
              child: _costsCategories(),
            ),
          ],
        ),
      ),
    ));
  }

  PreferredSize _appBar() {
    final appBarheight = AppBar().preferredSize.height;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarheight),
      child: BlocBuilder<CostsBloc, CostsState>(
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: Text(state.monthName),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<CostsBloc>().add(OpenAddModal());
                  },
                  icon: const Icon(Icons.add))
            ],
          );
        },
      ),
    );
  }

  Widget _costsPieChart() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, radius: 70, color: Colors.green),
            PieChartSectionData(value: 20, radius: 70, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _costsCategories() {
    return BlocBuilder<CostsBloc, CostsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.costCategories.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 25,
          ),
          itemBuilder: (context, index) => CostCategoryCard(
            category: categories[index],
          ),
          padding: const EdgeInsets.all(25),
        );
      },
    );
  }
}
