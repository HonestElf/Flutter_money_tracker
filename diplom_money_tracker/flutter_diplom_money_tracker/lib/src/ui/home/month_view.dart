import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/firestore_api.dart';

import 'package:flutter_diplom_money_tracker/src/ui/home/costs_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/costs_pie_chart.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_category_modal.dart';
import 'package:flutter_diplom_money_tracker/src/ui/utils/month_parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthView extends StatefulWidget {
  const MonthView({super.key});
  static const routeName = 'monthView';

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  late CollectionReference<CostCategory>? _categories;

  String? chosenMonth;
  @override
  void initState() {
    super.initState();

    chosenMonth = parseMonth(DateTime.now().month);

    _categories = getAllCategories();
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (context) {
        return const AddCategoryModal();
      },
    );
  }

  void openDateModal() async {
    final chosenDate = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (chosenDate != null) {
      setState(() {
        chosenMonth = parseMonth(chosenDate.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF9053EB),
        titleSpacing: 0,
        title: TextButton(
            onPressed: openDateModal,
            child: Text(
              chosenMonth ?? 'Месяц не выбран',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            )),
        actions: [
          IconButton(
              onPressed: () {
                openAddModal();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<CostCategory>>(
          stream: _categories
              ?.snapshots()
              .map((event) => event.docs.map((e) => e.data()).toList()),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: CostsPieChart(
                          categories: snapshot.data!,
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: CostsView(
                            categories: snapshot.data!,
                          )),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
