import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/firestore_api.dart';

import 'package:flutter_diplom_money_tracker/src/ui/home/costs_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/costs_pie_chart.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_category_modal.dart';
import 'package:flutter_diplom_money_tracker/src/ui/utils/month_parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthView extends StatefulWidget {
  const MonthView({super.key});
  static const routeName = 'monthView';

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  late CollectionReference<CostCategory>? _categories;

  int? chosenMonth;
  int? chosenYear;

  @override
  void initState() {
    super.initState();

    final currentDate = DateTime.now();

    chosenMonth = currentDate.month;
    chosenYear = currentDate.year;

    _categories = getFirebaseCollection();
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
    final chosenDate = await showMonthPicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (chosenDate != null) {
      setState(() {
        chosenMonth = chosenDate.month;
        chosenYear = chosenDate.year;
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
              parseMonth(chosenMonth),
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
          stream: _categories?.snapshots().map((event) => event.docs.map((e) {
                dynamic temp = e.data();

                return CostCategory(
                    categoryName: temp.categoryName,
                    categoryColor: temp.categoryColor,
                    items: temp.items.where((element) {
                      final parsedDate = DateTime.parse(element.costDay);
                      return parsedDate.month == chosenMonth &&
                          parsedDate.year == chosenYear;
                    }).toList());
              }).toList()),
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
